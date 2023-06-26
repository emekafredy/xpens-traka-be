# frozen_string_literal: true

module ControllerHelpers
  def sign_me_in
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @current_user = FactoryGirl.create(:user)
      sign_in :user, @current_user
    end
  end
end
