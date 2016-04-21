module SlackBotServer
  module Commands
    class Courses < SlackRubyBot::Commands::Base
      require_relative '../lib/dailybitsof'
      
      match /^courses (?<slug>\w*-\w*)$/ do |client, data, match|

#        client.say(channel: data.channel, text: "#{match['slug']}")
      	courses = Dailybitsof.courses(match['slug'])

      	message = {
          channel: data.user,
          as_user: true,
          mrkdwn: true,
          attachments: []
        }
        
       courses.each do |course|
        attachment = {
            title_link: "https://dailybitsof.com/courses/#{course['slug']}",
            title: "#{course['title']}",
            text: "#{course['description']}"
          }
        
        message[:attachments] << attachment
        
        end
        client.web_client.chat_postMessage(message)
        #client.web_client.im_open(message)

      end
    end
  end
end
