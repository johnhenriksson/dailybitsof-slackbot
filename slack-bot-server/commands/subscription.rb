module SlackBotServer
  module Commands
    class Subscription < SlackRubyBot::Commands::Base
      require_relative '../lib/dailybitsof'

      def self.call(client, data, _match)
      #match /^Start the course (?<slug>\w*-\w*)$/i do |client, data, match|
        #course = Dailybitsof.create_subscription(team_id, data.channel, match['slug'])

        #team = Team.find_or_create_from_env!

        team = "12345"

        client.say(channel: data.channel, text: "#{team}")

      end
    end
  end
end