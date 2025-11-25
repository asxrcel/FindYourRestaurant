class ChatsController < ApplicationController
  def create
  @chat = Chat.new(title: "Untitled")
  @chat.user = current_user
  if @chat.save
    @chat.messages.create(content:"Welcome to FindYourRestaurant, please give your location", role: "user")
    redirect_to chat_path(@chat)
  else
    render "challenges/show"
  end
  end

  def new
  end
  def show
    @chat = current_user.chats.find(params[:id])
    @message = Message.new
  end
end
