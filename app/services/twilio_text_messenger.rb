# frozen_string_literal: true

class TwilioTextMessenger

  def send_order(data)
    @distributor = data[:distributor]
    @items = data[:items]
    @phone_number = '+1' + data[:phone_number].to_s

    message = "Your order to #{@distributor.name} has been placed. You have ordered the following items: #{@items}"
    client = Twilio::REST::Client.new
    response = client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: '+17205038000',
      body: @phone_number
    )
  end

end
