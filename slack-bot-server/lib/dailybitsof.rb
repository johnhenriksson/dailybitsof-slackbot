class Dailybitsof

	def self.categories
		response = HTTParty.get('https://dailybitsof.com/api/categories')
		data = JSON.parse(response.body)

		return data
	end

	def self.courses(category, limit)
        response = HTTParty.get("https://dailybitsof.com/api/courses?category=#{category}&limit=#{limit}&order=recent&language=en")
        data = JSON.parse(response.body)

		return data
	end

	def self.course(channel_id)
		subscription = Subscription.where(:channel_id => channel_id)

		response = HTTParty.get("https://dailybitsof.com/api/users/#{subscription.dbo_id}/todays_lessons?access_token=#{ENV['DBO_ACCESS_TOKEN']}")
		data = JSON.parse(response.body)

		return data
	end

	def self.create_subscription(channel_id, course_slug)
		dbo_id = "#{channel_id}-slackbot"

		Subscription.create(:dbo_id => dbo_id, :channel_id => channel_id)

		query = {'subscription' => { 'username' => dbo_id }, 'access_token' => ENV['DBO_ACCESS_TOKEN']}
		headers = { 'Content-Type' => 'application/json' }
		request = HTTParty.post("https://dailybitsof.com/api/courses/#{course_slug}/subscriptions", :query => query, :headers => headers)
		data = JSON.parse(request.body)

		return data
	end

end