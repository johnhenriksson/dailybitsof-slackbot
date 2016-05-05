subscriptions = Subscription.all

subscriptions.each do |subscription|
	client = Slack::Web::Client.new(:token => subscription.team.token)
	client.auth_test
	client.chat_postMessage(channel: "#{subscription.team_id}", text: "Daily Courses", as_user: true)
end



