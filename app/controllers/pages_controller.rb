class PagesController < ApplicationController
  before_action :authenticate_user!
  def home
  end

  def dashboard
    @user = current_user
    @restaurants = @user.restaurants.where(params[:id])
  end
end
