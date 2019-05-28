class TextSenderJob < ApplicationJob
  queue_as :default

  def perform(message_data)
    TwilioTextMessenger.new.send_order(message_data)
  end
end
