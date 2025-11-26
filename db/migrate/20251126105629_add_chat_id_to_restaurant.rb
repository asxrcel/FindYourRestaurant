class AddChatIdToRestaurant < ActiveRecord::Migration[7.1]
  def change
    add_reference :restaurants, :chat, foreign_key: true
  end
end
