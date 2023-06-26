module ModelHelpers
  def create_user
    @user = create(:user)
  end

  def create_category
    @category = create(:category)
  end
end
