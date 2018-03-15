class ShowOrdersAction
  def initialize(message_data)
    @message = ShowOrdersMessage.new(message_data)
  end

  def respond
    "Looks like you asked me about orders :) Additional info: #{@message.search_query}"
  end
end