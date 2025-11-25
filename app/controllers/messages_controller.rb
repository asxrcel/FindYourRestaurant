class MessagesController < ApplicationController
  SYSTEM_PROMPT = prompt
def create
  @chat = current_user.chats.find(params[:chat_id])
  @message = Message.new(content: params[:message][:content])
  @message.chat = @chat
  @message.role = "user"
  if @message.save
      @ruby_llm_chat = RubyLLM.chat
      build_conversation_history
        response = @ruby_llm_chat.with_instructions(system_prompt).ask(@message.content)
        Message.create(role: "assistant", content: response.content, chat: @chat)
        redirect_to chat_messages_path(@chat)
        # @restaurants = Message.where(role: "assistant").last
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
    case @chat.messages.count
    when 1
      <<~PROMPT
        Ask the user: What's your location, with city and neighbourhood?
      PROMPT
    when 2
      <<~PROMPT
        Ask the user: What type of food do you want to eat?
      PROMPT
      when 3
      <<~PROMPT
        Ask the user: What's your budget to eat?
      PROMPT
      end
  end
end
