class OrdersMailer < ActionMailer::Base
  default from: "no-reply@example.com"

  def recent(pdf)
    attachments['order.pdf'] = pdf

    mail to: "irish@burstdev.com", subject: "Order PDF #{Time.zone.now.to_s(:short)}"
  end
end
