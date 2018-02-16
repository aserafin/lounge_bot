include Facebook::Messenger

Bot.on :message do |message|
  message.reply(text: message.text)
end