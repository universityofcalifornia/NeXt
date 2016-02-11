class PasswordResetEmail < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def password_reset user
    unless user.dont_receive_emails
      @user  = user
      mail :to => @user.email, :subject => "Reset your password"
    end
  end
end