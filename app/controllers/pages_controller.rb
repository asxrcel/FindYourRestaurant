class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @restaurants = current_user.restaurants.where(favorite: true)
  end
end
