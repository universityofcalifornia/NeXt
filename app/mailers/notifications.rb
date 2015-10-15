class Notifications < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def badge_received user_badge
    @user  = user_badge.user
    @badge = user_badge.badge

    mail :to => @user.email, :subject => "You received a badge!"
  end
end
