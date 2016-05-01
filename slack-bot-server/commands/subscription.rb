module SlackBotServer
  module Commands
    class Subscription < SlackRubyBot::Commands::Base
      require_relative '../lib/dailybitsof'

      match /^Start the course (?<slug>\S+)$/i do |client, data, match|

        subscription = Dailybitsof.create(data.channel, match['slug'], client.token)

   #      if subscription
   #      	course = Dailybitsof.course(match['slug'])

   #      	first_lesson_as_message = course['first_post']['content'].gsub!(/<br\s*[\/]?>/i, "\n\n").gsub!(/<p\s*[\/]?>/i, "\n\n")

	  #     	message = {
	  #         channel: data.channel,
	  #         as_user: true,
	  #         mrkdwn: true,
	  #         attachments: []
	  #       }

			# attachment = {
			# 	mrkdwn: true,
   #          	mrkdwn_in: ["text"],
			# 	color: "good",
			# 	text: "Thanks for signing up! Here's the first lesson. We'll send you daily lessons for the course *#{course['title']}* in this channel."
			#   }

			# message[:attachments] << attachment

	  #       attachment = {
	  #           color: "#82c6dc",
	  #           thumb_url: "#{course['image_url']}",
	  #           title_link: "#{course['first_post']['url']}",
	  #           title: "#{course['first_post']['title']}",
	  #           text: "#{ Sanitize.clean(first_lesson_as_message)}"
	  #         }
	        
	  #       message[:attachments] << attachment


   #      client.web_client.chat_postMessage(message)

	  #   else
	    	client.say(channel: data.channel, text: "#{subscription}")
	    # end
      end
    end
  end
end