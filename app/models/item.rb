class Item < ApplicationRecord
  has_many :categories
  has_many :photos
  validates :photos, presence: true
  accepts_nested_attributes_for :photos, allow_destroy: true
  validates :name, :price, :description, :item_condition_id, :burden_id, :prefectures_id,:days_id,:category_id,presence: true
end
