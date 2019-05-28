class EmailSenderJob < ApplicationJob
  queue_as :default

  def perform(email_data)
    RepresentativeNotifierMailer.send_order(email_data).deliver_now
  end
end
