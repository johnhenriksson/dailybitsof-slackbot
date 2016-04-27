class Dailybitsof

	def self.categories
		response = HTTParty.get('https://dailybitsof.com/api/categories')
		data = JSON.parse(response.body)

		return data
	end

	def self.courses(category, limit)
        response = HTTParty.get("https://dailybitsof.com/api/courses?category=#{category}&limit=#{limit}")
        data = JSON.parse(response.body)

		return data
	end

	def self.create_subscription(team_id, channel_id, course_slug)
		dbo_id = "#{team_id}-#{channel_id}-slackbot"

		Subscription.create!(:dbo_id => dbo_id ) do |sub|
			sub.team_id = team_id
			sub.channel_id = channel_id
		end

		query = {'subscription' => { 'username' => dbo_id }, 'access_token' => ENV['DBO_ACCESS_TOKEN']}
		headers = { 'Content-Type' => 'application/json' }
		request = HTTParty.post("https://dailybitsof.com/api/courses/#{course_slug}/subscriptions", :query => query, :headers => headers)
		data = JSON.parse(request.body)

		return data
	end

end