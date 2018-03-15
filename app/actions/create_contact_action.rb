class CreateContactAction
  def initialize(message_data)
    message = CreateContactMessage.new(message_data)
  end

  def respond
    "Looks like you want to add new contact"
  end
end