class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @chat = RubyLLM.chat
    @response = @chat.ask("What is Ruby on Rails?")
  end
end
