module SlackBotServer
  module Commands
    class Categories < SlackRubyBot::Commands::Base
      require_relative '../lib/dailybitsof'
      
      def self.call(client, data, _match)

      	categories = Dailybitsof.categories

      	message = {
          channel: data.channel,
          as_user: true,
          mrkdwn: true,
          attachments: []
        }
        
       categories.each do |category|
        attachment = {
            title_link: "https://dailybitsof.com/categories/#{category['slug']}",
            title: "#{category['name']}",
            text: "#{category['description']}\n\nList courses in this category with `courses #{category['slug']}"
          }
        
        message[:attachments] << attachment
        
        end
        client.web_client.chat_postMessage(message)
        #client.web_client.im_open(message)
      end
    end
  end
end
