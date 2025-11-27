class AddGeoAndPhotoToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :latitude, :float
    add_column :restaurants, :longitude, :float
    add_column :restaurants, :photo_url, :string
  end
end
