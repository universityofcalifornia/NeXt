class PasswordResetEmail < ActionMailer::Base
  default from:     "mailer@ucnext.org",
          reply_to: "no-reply@ucnext.org"

  def password_reset user
    @user  = user

    mail :to => 'shaun965@hotmail.com', :subject => "Reset your password"
  end
end