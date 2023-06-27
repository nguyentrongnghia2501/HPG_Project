class NotificationMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('mailer.welcome_subject'))
  end
end
