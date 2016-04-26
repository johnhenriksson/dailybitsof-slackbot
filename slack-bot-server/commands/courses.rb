module SlackBotServer
  module Commands
    class Courses < SlackRubyBot::Commands::Base
      require_relative '../lib/dailybitsof'
      
      match /^Show me the (?<limit>\d*) latest courses in (?<slug>\w*-\w*)$/i do |client, data, match|

#        client.say(channel: data.channel, text: "#{match['slug']}")
      	courses = Dailybitsof.courses(match['slug'], match['limit'])

      	message = {
          channel: data.channel,
          as_user: true,
          mrkdwn: true,
          attachments: []
        }
        
       courses.each do |course|
        attachment = {
            color: "#82c6dc",
            thumb_url: "#{course['image_url']}",
            title_link: "https://dailybitsof.com/courses/#{course['slug']}",
            title: "#{course['title']}",
            text: "#{ Sanitize.clean(course['description'])}"
          }
        
        message[:attachments] << attachment

        attachment = {
            mrkdwn: true,
            mrkdwn_in: ["text"],
            text: "Start this course with the command `Start the #{course['slug']} course`"
          }
        
        message[:attachments] << attachment


        end
        client.web_client.chat_postMessage(message)
        #client.web_client.im_open(message)

      end
    end
  end
end
