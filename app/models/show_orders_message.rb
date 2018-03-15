class ShowOrdersMessage
  attr_reader :message_data

  def initialize(message_data)
    @message_data = message_data
  end

  def search_query
    {
      from: from,
      to: to,
      limit: limit,
      customers: customers
    }
  end

  def limit
    5
  end

  def from
    Time.parse(message_data.entities.dig('datetime').first['from']['value']) rescue 5.days.ago
  end

  def to
    Time.parse(message_data.entities.dig('datetime').first['to']['value']) rescue Time.zone.now
  end

  def customers
    (message_data.entities['contact'] || []).map { |entity| entity['value'] }
  end
end