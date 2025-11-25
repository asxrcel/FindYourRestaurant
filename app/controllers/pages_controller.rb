class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    # @chat = current_user.chat.find()
    @user = current_user
    @restaurants = @user.restaurants.where(params[:id])
  end
end
