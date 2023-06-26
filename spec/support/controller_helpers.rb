module ControllerHelpers
  def sign_me_in
    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @current_user = FactoryGirl.create(:user)
      sign_in :user, @current_user
    end 
  end 
end
