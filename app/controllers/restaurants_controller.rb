class RestaurantsController < ApplicationController
  def update
    @chat = current_user.chats.find(params[:chat_id])
    selected_ids = params[:restaurant_ids] || []
    @chat.restaurants.each do |restaurant|
      restaurant.update(favorite: selected_ids.include?(restaurant.id.to_s))
    end
    redirect_to root_path
  end

  def destroy
     @restaurant = Restaurant.find(params[:id])
     @restaurant.destroy
     redirect_to restaurant_path, status: :see_other
  end

end
