# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        def signup
          user = User.new(sign_up_params)

          if user.save
            render_serialized_response(AuthSerializer, user)
          else
            bad_request_error(user)
          end
        end

        private

        def sign_up_params
          params.permit(:email, :password, :username)
        end
      end
    end
  end
end
