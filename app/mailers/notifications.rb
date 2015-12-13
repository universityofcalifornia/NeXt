class Notifications < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def badge_received badge, user
    @badge      = badge
    @user       = user
    @link_style = "color: #9c5500;"

    mail :to => @user.email, :subject => "You received a badge!"
  end
end
