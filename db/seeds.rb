# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Restaurant.new(name: "Indian Food", adress: "61 rue de servan, 75011", budget: "20-40€", category: "indian", rating: 3.8, localisation: "Paris")

Restaurant.new(name: "Chinese Food", adress: "45 rue de servan, 75011", budget: "15-35€", category: "chinese", rating: 4.8, localisation: "Paris")

Restaurant.new(name: "African Food", adress: "12 rue de servan, 75011", budget: "10-20€", category: "african", rating: 3.8, localisation: "Paris")

Restaurant.new(name: "Master Poulet", adress: "89 rue d'Oberkampf, 75011", budget: "10-15€", category: "fast-food", rating: 4.2 , localisation: "Paris")

Restaurant.new(name: "Good Meal", adress: "61 rue de Republique, 75010", budget: "10-15€", category: "fast-food", rating: 4.3, localisation: "Paris")

Restaurant.new(name: "French Food", adress: "90 rue de servan, 75011", budget: "20-40€", category: "french", rating: 4.8, localisation: "Paris")

Restaurant.new(name: "Thaï Land", adress: "61 rue de Oberkampf, 75011", budget: "10-30€", category: "thaï", rating: 5.0, localisation: "Paris")

Restaurant.new(name: "Burger Food", adress: "69 rue de servan, 75011", budget: "20-40€", category: "american", rating: 4.0, localisation: "Paris")

Restaurant.new(name: "Biryani Land: "96 rue de servan, 75011", budget: "20-40€", category: "indian", rating: 4.8 , localisation: "Paris")
