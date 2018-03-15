class MessageData
  attr_reader :message

  MIN_CONFIDENCE = 0.5

  def initialize(message)
    @message = message
  end

  def sender_id
    @sender_id ||= message.dig('sender', 'id')
  end

  def text
    @text ||= message.dig('message', 'text')
  end

  def entities
    message.dig('message', 'nlp', 'entities')
  end

  def action_key
    intent_entity_key || greetings_key || thanks_key || bye_key
  end

  def intent_entity
    @intent ||= (message.dig('message', 'nlp', 'entities', 'intent') || []).select do |entity|
      entity['confidence'] > MIN_CONFIDENCE
    end.sort_by { |entity| entity['confidence'] }.first
  end

  def intent_entity_key
    @intent_entity_key ||= intent_entity.try(:[], 'value')
  end

  private

  def greetings_key
    (message.dig('message', 'nlp', 'entities', 'greetings').try(:first).try(:[], 'confidence') || 0) > MIN_CONFIDENCE ? 'greetings' : nil
  end

  def thanks_key
    (message.dig('message', 'nlp', 'entities',  'thanks').try(:first).try(:[], 'confidence') || 0) > MIN_CONFIDENCE ? 'thanks' : nil
  end

  def bye_key
    (message.dig('message', 'nlp', 'entities', 'bye').try(:first).try(:[], 'confidence') || 0) > MIN_CONFIDENCE ? 'bye' : nil
  end
end