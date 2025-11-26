class MessagesController < ApplicationController
def create
  @chat = current_user.chats.find(params[:chat_id])
  @message = Message.new(content: params[:message][:content])
  @message.chat = @chat
  @message.role = "user"
  if @message.save
      @ruby_llm_chat = RubyLLM.chat
      build_conversation_history
        response = @ruby_llm_chat.with_instructions(system_prompt).ask(@message.content)
          begin
            json = JSON.parse(response.content)
            is_json = json.is_a?(Hash) && json.key?("restaurants")
            rescue JSON::ParserError
            is_json = false
          end
            if is_json
            @display     = json["display"]
            @restaurants = json["restaurants"]
              @restaurants.each do |restaurant|
               @chat.restaurants.create!(
                name:     restaurant["name"],
                address:  restaurant["address"],
                rating:   restaurant["rating"],
                budget:   restaurant["budget"],
                category: restaurant["category"],
                user:     current_user
                )
            end
            li_list = @restaurants.map {|r| "<li>#{r["name"]}</li>"}.join
            final_content = "#{@display}<ul>#{li_list}</ul>"
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
      when  3
      <<~PROMPT
    You are a Culinary Guide. Your task is to recommend 6 restaurants based on user preferences.

    User preferences (last 3 user messages):
    #{@chat.messages.where(role: "user").last(3).map(&:content).join("\n")}

    You MUST answer ONLY with valid JSON.
    No markdown, no explanation, no backticks.

    The JSON must have:
    - "display": a friendly message for the user
    - "restaurants": an array of EXACTLY 6 restaurant objects

    Example structure:

    {
      "display": "Voici 6 restaurants qui pourraient te plaire...",
      "restaurants": [
        {
          "name": "Restaurant Name",
          "address": "Restaurant Address",
          "rating": 4.5,
          "budget": "$$",
          "category": "Italian"
        }
      ]
    }
  PROMPT
      end
  end
end
