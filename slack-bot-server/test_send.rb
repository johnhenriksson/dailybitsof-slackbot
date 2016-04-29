

client = Slack::Web::Client.new
client.auth_test
client.chat_postMessage(channel: "T10GLEF8B", text: "Hej", as_user: true)



