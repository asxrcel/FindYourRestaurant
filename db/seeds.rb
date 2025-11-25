# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "generating 9 restaurants"

Restaurant.new(user_id: 1, name: "Indian Food", address: "61 rue de servan, 75011", budget: "20-40€", category: "indian", rating: 3.8)
Restaurant.new(user_id: 1, name: "Chinese Food", address: "45 rue de servan, 75011", budget: "15-35€", category: "chinese", rating: 4.8)
Restaurant.new(user_id: 1, name: "African Food", address: "12 rue de servan, 75011", budget: "10-20€", category: "african", rating: 3.8)
Restaurant.new(user_id: 1, name: "Master Poulet", address: "89 rue d'Oberkampf, 75011", budget: "10-15€", category: "fast-food", rating: 4.2 )
Restaurant.new(user_id: 1, name: "Good Meal", address: "61 rue de Republique, 75010", budget: "10-15€", category: "fast-food", rating: 4.3)
Restaurant.new(user_id: 1, name: "French Food", address: "90 rue de servan, 75011", budget: "20-40€", category: "french", rating: 4.8)
Restaurant.new(user_id: 1, name: "Thaï Land", address: "61 rue de Oberkampf, 75011", budget: "10-30€", category: "thaï", rating: 5.0)
Restaurant.new(user_id: 1, name: "Biryani Land", address: "96 rue de servan, 75011", budget: "20-40€", category: "indian", rating: 4.8 )
Restaurant.new(user_id: 1, name: "NemNem", address: "40 Xuanwumenwai Dajie Beijing 100052", budget: "6-15$", category: "indian", rating: 4.1)

puts "generation done"
