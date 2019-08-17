class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :comments
  has_one :credit
  has_many :buyer_items, foreign_key: "buyer_id", class_name: "Item"
  has_many :saling_items, -> { where("buyer_id is NULL")}, foreign_key: "salier_id", class_name: "Item"
  has_many :sold_items, -> { where("buyer_id is NULL")}, foreign_key: "salier_id", class_name: "Item"

  validates :nickname, :first_name, :first_name_kana, :last_name, :last_name_kana, :postal_cord, :address, :email, :password, :phone_number, presence: true
end
