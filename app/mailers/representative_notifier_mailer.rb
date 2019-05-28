class RepresentativeNotifierMailer < ApplicationMailer
  default from: 'BarStock@barstock.com'
  def send_order(data)
    @data = data
    mail(to: data[:rep_email], subject: "#{data[:name]}'s Order")
  end
end
