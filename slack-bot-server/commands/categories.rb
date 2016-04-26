module SlackBotServer
  module Commands
    class Categories < SlackRubyBot::Commands::Base
      require_relative '../lib/dailybitsof'
      
      match /^Show me the course categories$/i do |client, data, match|

      	categories = Dailybitsof.categories

      	message = {
          channel: data.channel,
          as_user: true,
          mrkdwn: true,
          attachments: []
        }
        
       categories.each do |category|
        attachment = {
            color: "#82c6dc",
            title_link: "https://dailybitsof.com/categories/#{category['slug']}",
            title: "#{category['name']}",
            text: "#{category['description']}}"
          }
        
        message[:attachments] << attachment
        
        attachment = {
            mrkdwn: true,
            mrkdwn_in: ["text"],
            text: "List courses in this category with `Show me the #num latest courses in #{category['slug']}`"
          }
        
        message[:attachments] << attachment

        end
        client.web_client.chat_postMessage(message)
        #client.web_client.im_open(message)
      end
    end
  end
end
