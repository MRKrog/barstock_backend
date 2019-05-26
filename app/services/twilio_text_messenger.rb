class TwilioTextMessenger

  def send_order(data)
    @business = data[:business]
    @items = data[:items]
    @phone_number = '+1' + data[:phone_number].to_s

    message = "#{@business} has just placed an order. The following items: #{@items}"
    client = Twilio::REST::Client.new
    response = client.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: @phone_number,
      body: message
    )
  end

end
