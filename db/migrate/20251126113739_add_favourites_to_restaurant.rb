class AddFavouritesToRestaurant < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :favorite, :boolean, default: false
  end
end
