# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome_user(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Welcome #{@user.username}",
      body: 'Welcome to the platform'
    )
  end
end
