require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "authorize_confirmation" do
    mail = NotificationMailer.authorize_confirmation
    assert_equal "Authorize confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "welcome_email" do
    mail = NotificationMailer.welcome_email
    assert_equal "Welcome email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
