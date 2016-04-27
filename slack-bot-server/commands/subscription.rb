module SlackBotServer
  module Commands
    class Subscription < SlackRubyBot::Commands::Base
      require_relative '../lib/dailybitsof'

      match /^Start the course (?<slug>\w*-\w*)$/i do |client, data, match|
        subscription = Dailybitsof.create_subscription(data.channel, match['slug'])

        client.say(channel: data.channel, text: "#{subscription}")

      end
    end
  end
end