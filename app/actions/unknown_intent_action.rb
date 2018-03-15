class UnknownIntentAction
  def initialize(message)
    @message = message
  end

  def respond
    I18n.t('unknown_intent').sample
  end
end