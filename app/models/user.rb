class User < ApplicationRecord
  has_many :restaurants, dependent: :destroy
  has_many :chats
  has_one :profil
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
