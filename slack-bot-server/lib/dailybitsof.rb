class Dailybitsof

	@api_url = "https://dailybitsof.com/api/"

	@api_key = ENV['DBO_ACCESS_TOKEN']

	def self.categories
		response = HTTParty.get("#{@api_url}categories")
		data = JSON.parse(response.body)

		return data
	end

	def self.courses(category, limit)
        response = HTTParty.get("#{@api_url}courses?category=#{category}&limit=#{limit}&order=recent&language=en")
        data = JSON.parse(response.body)

		return data
	end

	def self.course(course_slug)
		response = HTTParty.get("#{@api_url}courses/#{course_slug}")
		data = JSON.parse(response.body)

		return data

	end

	def self.create(channel_id, course_slug, token)
		
		team_id = Team.find_by(:token => token).id
		username = "#{team_id}#{channel_id}slack"
		
		query = {'subscription' => { 'username' => username }, 'access_token' => @api_key}
		headers = { 'Content-Type' => 'application/json' }
		request = HTTParty.post("#{@api_url}/courses/#{course_slug}/subscriptions", :query => query, :headers => headers)
		data = JSON.parse(request.body)

		subscription = Subscription.find_or_create_by(:team_id => team_id, :dbo_id => data['user_id'], :channel_id => channel_id)

		return subscription

	end

	def self.get_lessons(dbo_id)
		@subscription = Subscription.find_by(:dbo_id => dbo_id)

   		response = HTTParty.get("#{@api_url}users/#{dbo_id}/todays_lessons?access_token=9f52830fc2adf8d23aa781d1df361ce1")
   		unless response.code == 404
   			data = JSON.parse(response.body)
   			if data["last_delivery_date"].to_date <= @subscription.last_delivery_date
   				@subscription.update(:last_delivery_date => Date.today)
		        return data["posts"]
		    else
		        return false
		    end
   		else
   			return false
   		end
	end

	def self.daily_lesson

		channels = Subscription.where(:dbo_id == true)

		channels.each do |channel|
			data = get_lessons(channel.dbo_id)

			data.each do |data|
				# puts data

				client = Slack::Web::Client.new(:token => channel.team.token)
				client.auth_test

				message = {
		          channel: channel.channel_id,
		          as_user: true,
		          mrkdwn: true,
		          attachments: []
		        }

    			attachment = {
				  mrkdwn: true,
            	  mrkdwn_in: ["text"],
				  color: "good",
				  text: "Here's your daily lesson in the course #{data['course']['slug']}"
			    }

			    message[:attachments] << attachment

			    lesson_as_message = data['content'].gsub!(/<br\s*[\/]?>/i, "\n\n").gsub!(/<p\s*[\/]?>/i, "\n\n")

    	        attachment = {
	        	  mrkdwn: true,
            	  mrkdwn_in: ["text"],
	              color: "#82c6dc",
	              # thumb_url: "#{data['image_url']}",
	              title_link: "#{data['url']}",
	              title: "#{data['title']}",
	              text: "#{ Sanitize.clean(lesson_as_message)}"
	            }
	        
	        	message[:attachments] << attachment

			    client.chat_postMessage(message)

			end
		end

		# subscriptions = Subscription.all

		# subscriptions.each do |subscription|
			# client = Slack::Web::Client.new(:token => subscription.team.token)
			# client.auth_test

			# course = Dailybitsof.course(match['slug'])

        	# first_lesson_as_message = course['first_post']['content'].gsub!(/<br\s*[\/]?>/i, "\n\n").gsub!(/<p\s*[\/]?>/i, "\n\n")

        	# lessons = get_lessons(subscription.last_delivery_date, subscription.dbo_id)
			
			# lessons.each do |lesson|
				# puts lesson['title']
			# end
			
			#client.chat_postMessage(channel: subscription.channel_id, text: "#{data[0]['posts']}")
			  #send message to bot with data['title'] and data['content']

			# lesson_as_message = data['posts'][0]['content'] #.gsub!(/<br\s*[\/]?>/i, "\n\n").gsub!(/<p\s*[\/]?>/i, "\n\n")

			# message = {
	  #         channel: subscription.channel_id,
	  #         as_user: true,
	  #         mrkdwn: true,
	  #         attachments: []
	  #       }

			# attachment = {
			# 	mrkdwn: true,
   #          	mrkdwn_in: ["text"],
			# 	color: "good",
			# 	text: "Here's your daily lesson in the course #{data['course']['slug']}"
			#   }

			# message[:attachments] << attachment

	  #       attachment = {
	  #           color: "#82c6dc",
	  #           # thumb_url: "#{data['image_url']}",
	  #           title_link: "#{data['url']}",
	  #           title: "#{data['title']}",
	  #           text: "#{ Sanitize.clean(lesson_as_message)}"
	  #         }
	        
	  #       message[:attachments] << attachment


   #      	client.web_client.chat_postMessage(message)
		# end

	end
end


