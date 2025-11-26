class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @restaurants = current_user.restaurants.last(5)
  end

end
