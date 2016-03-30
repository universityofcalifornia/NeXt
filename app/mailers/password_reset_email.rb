class PasswordResetEmail < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def password_reset user
    @user = user
    mail(:to => user.email, :subject => "Reset your password").deliver
  end

end