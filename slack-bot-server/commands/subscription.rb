module SlackBotServer
  module Commands
    class Subscription < SlackRubyBot::Commands::Base
      require_relative '../lib/dailybitsof'

      match /^Start the course (?<slug>\S+)$/i do |client, data, match|
        subscription = Dailybitsof.create(data.channel, match['slug'])

        if true
        # 	course = Dailybitsof.courses(match['slug'], match['limit'])

	      	# message = {
	       #    channel: data.channel,
	       #    as_user: true,
	       #    mrkdwn: true,
	       #    attachments: []
	       #  }
	        
	       # courses.each do |course|
	       #  attachment = {
	       #      color: "#82c6dc",
	       #      thumb_url: "#{course['image_url']}",
	       #      title_link: "https://dailybitsof.com/courses/#{course['slug']}",
	       #      title: "#{course['title']}",
	       #      text: "#{ Sanitize.clean(course['description'])}"
	       #    }
	        
	       #  message[:attachments] << attachment

	       #  attachment = {
	       #      mrkdwn: true,
	       #      mrkdwn_in: ["text"],
	       #      text: "Start this course with the command `Start the course #{course['slug']}`"
	       #    }
	        
	       #  message[:attachments] << attachment
        #end

        #client.web_client.chat_postMessage(message)

	    else
	    	client.say(channel: data.channel, text: "Sorry, something went wrong.")
	    end
      end
    end
  end
end