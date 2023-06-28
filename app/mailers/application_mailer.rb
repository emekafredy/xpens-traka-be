# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'emy.testt@gmail.com'
  layout 'mailer'
end
