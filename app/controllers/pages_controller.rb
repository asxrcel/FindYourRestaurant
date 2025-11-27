class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @restaurants = current_user.restaurants.where(favorite: true)
    @my_profile = flash[:my_profile] || current_user.profil&.content
  end
end
