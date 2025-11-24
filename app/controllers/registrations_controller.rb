class RegistrationsController < ApplicationController
  def create
    raise
    @user = User.new(user_params)
    @user.name = params[:name]
    @user.save
  end
private
def user_params
  params.require(:user).permit(:name, :last_name, :email, :password)
end
end
