class PagesController < ApplicationController
  def home
    @chat = RubyLLM.chat
    @response = @chat.ask("What is Ruby on Rails?")
  end
end
