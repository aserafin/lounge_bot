class GreetingsAction
  def respond
    I18n.t('greetings').sample
  end
end