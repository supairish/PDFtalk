require 'test_helper'

class OrdersMailerTest < ActionMailer::TestCase
  test "recent" do
    mail = OrdersMailer.recent
    assert_equal "Recent", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
