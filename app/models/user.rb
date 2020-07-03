class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 7..128
  validates :first_name, :last_name, :first_name_kana, :last_name_kana, :nickname, :birthday ,presence: true
  validates_format_of :first_name_kana, with:/\A[ぁ-んー－]+\z/
  validates_format_of :last_name_kana, with:/\A[ぁ-んー－]+\z/
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_one :address, dependent: :destroy
  has_many :items, dependent: :destroy
  has_one :credit_card, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorites,through: :favorites, source: :item
end