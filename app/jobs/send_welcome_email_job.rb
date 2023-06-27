class SendWelcomeEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    NotificationMailer.welcome_email(user).deliver_now
  end
end
