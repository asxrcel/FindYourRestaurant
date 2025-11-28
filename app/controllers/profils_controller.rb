class ProfilsController < ApplicationController

  def create
    @restaurants = current_user.restaurants.where(favorite: true)
    @restaurantNames = @restaurants.map do |restaurant|
      restaurant.name
    end.join(", ")
    @restaurantBudgets = @restaurants.map do |restaurant|
      restaurant.budget
    end.join(", ")
    @restaurantAdsresses = @restaurants.map do |restaurant|
      restaurant.address
    end.join(", ")
    @restaurantRatings = @restaurants.map do |restaurant|
      restaurant.rating
    end.join(", ")
    @restaurantCategories = @restaurants.map do |restaurant|
      restaurant.category
    end.join(", ")

    chat = RubyLLM.chat

    prompt = <<~PROMPT
        You are my best friend, you give friendly advices and have a good understanding of who I am.
        Describe me based on my favourite restaurants, in less than 60 words.
        Here are the names : #{@restaurantNames}
        Here are their categories : #{@restaurantCategories}
        Be kind and creative about the overall feeling you get from the list.
        write something directly readable, without markdown
      PROMPT

    response = chat.ask(prompt)
    profil = current_user.profil || current_user.build_profil
    profil.title   = "n.a"
    profil.content = response.content

    # @my_profile = Profil.new(content: response.content, title: "n.a")
    # @my_profile.user = current_user

    profil.save!
    redirect_to root_path, flash: {my_profile: profil.content}
  end
end
