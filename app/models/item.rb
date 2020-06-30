class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :photos, dependent: :destroy
  belongs_to :user
  validates :photos, presence: true, allow_nil: true
  accepts_nested_attributes_for :photos, allow_destroy: true
  validates :name, :description, :item_condition_id, :burden_id, :prefectures_id,:days_id,:category_id,presence: true
  validates :name, length: { maximum: 40 }
  validates :description, length: { maximum: 1000 }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999,message:"を300円から9999999円までの間で入力してください"}
  validates :category_id, numericality: { greater_than_or_equal_to: 159, less_than_or_equal_to: 1000,message:"を入力してください"}
end
