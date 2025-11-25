puts "Clean up of old dirty data"
Restaurant.destroy_all
User.destroy_all

puts "Calling Sid"

sid = User.create!(
  email: "sid@mail.com",
  password: "secret",
  name: "Sid",
  last_name: "Weather",
)

puts "generating 9 restaurants for him"

Restaurant.create!(user: sid, name: "Indian Food", address: "61 rue servan, 75011", budget: "20-40€", category: "Indian", rating: 3.8)
Restaurant.create!(user: sid, name: "Chinese Food", address: "45 rue servan, 75011", budget: "15-35€", category: "Chinese", rating: 4.8)
Restaurant.create!(user: sid, name: "African Food", address: "12 rue servan, 75011", budget: "10-20€", category: "African", rating: 3.8)
Restaurant.create!(user: sid, name: "Master Poulet", address: "89 rue d'Oberkampf, 75011", budget: "10-15€", category: "Fast-food", rating: 4.2 )
Restaurant.create!(user: sid, name: "Good Meal", address: "61 rue de Republique, 75010", budget: "10-15€", category: "Fast-food", rating: 4.3)
Restaurant.create!(user: sid, name: "French Food", address: "90 rue servan, 75011", budget: "20-40€", category: "French", rating: 4.8)
Restaurant.create!(user: sid, name: "Thaï Land", address: "61 rue de Oberkampf, 75011", budget: "10-30€", category: "Thaï", rating: 5.0)
Restaurant.create!(user: sid, name: "Biryani Land", address: "96 rue servan, 75011", budget: "20-40€", category: "Indian", rating: 4.8 )
Restaurant.create!(user: sid, name: "NemNem", address: "40 Xuanwumenwai Dajie Beijing 100052", budget: "6-15$", category: "Indian", rating: 4.1)

puts "generation done"
