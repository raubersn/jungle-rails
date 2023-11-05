class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @category = Category.new(user_params)

    if @category.save
      # redirect_to [:user], notice: 'User created!'
    else
      # render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(
      # :first_name
    )
  end
end
