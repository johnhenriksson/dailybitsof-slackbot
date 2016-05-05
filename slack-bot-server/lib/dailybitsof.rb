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

	def self.todays_lesson(channel_id, team_id)
		data = []
		subscriptions = Subscription.where(:channel_id => channel_id).where(:team_id => team_id)

		subscriptions.each do |subscription|
		
		response = HTTParty.get("#{@api_url}users/#{subscription.dbo_id}/todays_lessons?access_token=#{@api_key}")
		data << JSON.parse(response.body)
		
		end

		return data
	end

	def self.create(channel_id, course_slug, token)
		
		team_id = Team.find_by(:token => token).id
		username = "#{team_id}#{channel_id}slack"
		
		query = {'subscription' => { 'username' => username }, 'access_token' => @api_key}
		headers = { 'Content-Type' => 'application/json' }
		request = HTTParty.post("#{@api_url}/courses/#{course_slug}/subscriptions", :query => query, :headers => headers)
		data = JSON.parse(request.body)

		subscription = Subscription.new(:team_id => team_id, :dbo_id => data['user_id'], :channel_id => channel_id, :username => username, :course_slug => course_slug, :last_delivery_date => data['last_delivery_date'])

		if subscription.save
			return subscription
		else
			return false
		end

	end
end


