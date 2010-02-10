class GuideSender < ActionMailer::Base
  def send_guide(order)
    subject    "Link to riga stag guide"
    recipients order.buyer.email
    from       "rigastag_guides@gmail.com"
    reply_to   "rigastag_guides@gmail.com"
    sent_on    Time.now
    content_type  "text/html"
    body       :order => order
  end
end
