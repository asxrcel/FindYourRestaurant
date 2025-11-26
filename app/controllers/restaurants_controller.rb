class RestaurantsController < ApplicationController

  def destroy
     @restaurant = Restaurant.find(params[:id])
     @restaurant.destroy
     redirect_to restaurant_path, status: :see_other
  end

end
