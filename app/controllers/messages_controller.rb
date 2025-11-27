require "net/http"
require "uri"
require "json"
class MessagesController < ApplicationController
  def create
    @chat = current_user.chats.find(params[:chat_id])
    @message = Message.new(content: params[:message][:content])
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      @ruby_llm_chat = RubyLLM.chat.with_temperature(0.0)
      build_conversation_history
      response = @ruby_llm_chat.with_instructions(system_prompt).ask(@message.content)
        begin
          json = JSON.parse(response.content)
        rescue JSON::ParserError
          json = nil
        end
          if json.is_a?(Hash) && json.key?("search_query")
            search_query = json["search_query"]
            location     = json["location"]
            cuisine      = json["cuisine"]
            full_query = if location.present?
                      "#{search_query} #{location}"
                     else
                      search_query
                     end
            places = google_places_text_search(full_query)
            Rails.logger.info "Google Places raw results (first): #{places.first.inspect}"
             @restaurants = places.first(6).map do |place|
              photo_ref = place["photos"][0]["photo_reference"]
              {
              "name"     => place["name"],
              "address"  => place["formatted_address"],
              "rating"   => place["rating"],
              "budget"   => place["price_level"],
              "category" => cuisine,
              "latitude" => place["geometry"]["location"]["lat"],
              "longitude" => place["geometry"]["location"]["lng"],
              "photo" => google_places_photo_url(photo_ref)
              }
              end
            @restaurants.each do |restaurant|
              @chat.restaurants.create!(
              name:     restaurant["name"],
              address:  restaurant["address"],
              rating:   restaurant["rating"],
              budget:   restaurant["budget"],
              category: cuisine.capitalize,
              user:     current_user,
              latitude:  restaurant["latitude"],
              longitude: restaurant["longitude"],
              photo_url: restaurant["photo"]
              )
            end
            li_list = @restaurants.map {|r| "<li>#{r["name"]}</li>"}.join
            final_content = "Voici quelques restaurants que j'ai trouvés pour toi, Bon appétit"
            Message.create(
              role: "assistant",
              content:final_content,
              chat: @chat
              )
          else
            Message.create(
            role: "assistant",
            content: response.content,
            chat: @chat
            )
          end
            redirect_to chat_messages_path(@chat)
            @chat.generate_title_from_first_message
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def build_conversation_history
    @chat.messages.each do |message|
      @ruby_llm_chat.add_message(message)
    end
  end

  def system_prompt
    case @chat.messages.where(role:"user").count
    when 1
      <<~PROMPT
        Ask the user: What type of food do you want to eat?
      PROMPT
      when 2
      <<~PROMPT
        Ask the user: What's your budget to eat?
      PROMPT
      when 3
      <<~PROMPT
      You are a helper that converts a conversation into JSON parameters
      for a Google Places restaurant search.

      You MUST NOT invent restaurant names.
      You MUST ONLY return search parameters.

      Read the last 3 user messages and output ONLY valid JSON
      (no markdown, no explanation, no backticks).
       User messages (last 3):
      #{@chat.messages.where(role: "user").last(3).map(&:content).join("\n")}
      JSON shape:
        {
        "search_query": "short text query to send to Google Places, in French if user speaks French",
        "location": "city or area",
        "cuisine": "type of food (e.g. italian, sushi, burger, vegan...)",
        "max_price_level": 0,   // integer between 0 and 4 (0 = very cheap, 4 = very expensive)
        "radius_meters": 2000   // integer, default 2000 if not clear
      }
      PROMPT
    end
  end
  def google_places_text_search(query)
  api_key = ENV["GOOGLE_API_KEY"]
  url = URI(
    "https://maps.googleapis.com/maps/api/place/textsearch/json" \
    "?query=#{URI.encode_www_form_component(query)}" \
    "&type=restaurant" \
    "&key=#{api_key}"
  )

  response = Net::HTTP.get_response(url)
  json = JSON.parse(response.body)

  json["results"]
  end

  def google_places_photo_url(photo_reference, maxwidth: 800)
  api_key = ENV["GOOGLE_API_KEY"]
  return nil if photo_reference.blank?

  "https://maps.googleapis.com/maps/api/place/photo" \
    "?maxwidth=#{maxwidth}" \
    "&photo_reference=#{photo_reference}" \
    "&key=#{api_key}"
end
end
