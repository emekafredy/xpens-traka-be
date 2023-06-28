# frozen_string_literal: true

class UserMailerJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    @user = User.find(user_id)
    UserMailer.welcome_user(@user).deliver_now
  end
end
