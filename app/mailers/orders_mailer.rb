class OrdersMailer < ActionMailer::Base
  default from: "no-reply@example.com"

  def recent(order, pdf)
    attachments["order-#{order.id}.pdf"] = pdf

    mail to: "irish@burstdev.com", subject: "Order PDF #{Time.zone.now.to_s(:short)}"
  end
end
