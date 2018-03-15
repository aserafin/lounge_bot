include Facebook::Messenger

Bot.on :message do |message|
  message.mark_seen
  message.typing_on

  pp message.messaging

  message_data = MessageData.new(message.messaging)

  response = case message_data.action_key
               when 'greetings' then GreetingsAction.new.respond
               when 'show_orders' then ShowOrdersAction.new(message_data).respond
               when 'create_contact' then CreateContactAction.new(message_data).respond
               else
                 UnknownIntentAction.new(message_data).respond


  end

  message.reply(text: response)
end