class ChatsController < ApplicationController
  def create
  @chat = Chat.new(title: "New chat")
  @chat.user = current_user
  if @chat.save
    @chat.messages.create(content:"Welcome to FindYourRestaurant, please give your location", role: "assistant")
    redirect_to chat_path(@chat)
  else
    render "challenges/show"
  end
  end
  def show
    @chat = current_user.chats.find(params[:id])
    @label = label
    @message = Message.new
    @restaurants = @chat.restaurants.last(5)
  end
  private
  def label
    case @chat.messages.where(role:"user").count
    when 0
      "Send your location"
    when 1
      "Send the type of food"
    when 2
      "Send your budget"
    end
  end
end
