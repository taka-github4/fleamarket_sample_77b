class Item < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :category
  has_many :photos, dependent: :destroy
  validates :photos, presence: true, allow_nil: true
  accepts_nested_attributes_for :photos, allow_destroy: true
  validates :name, :description, :item_condition_id, :burden_id, :prefectures_id,:days_id,:category_id,presence: true
  validates :name, length: { maximum: 40 }
  validates :description, length: { maximum: 1000 }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999,message:"を300円から9999999円までの間で入力してください"}
  validates :category_id, numericality: { greater_than_or_equal_to: 159, less_than_or_equal_to: 1330,message:"を入力してください"}
  has_many :favorites, dependent: :destroy
  def previous
    Item.where("id < ?",id).order("id DESC").first
  end

  def next
    Item.where("id > ?",id).order("id ASC").first
  end


  def set_items
    if self.root?
      first_id = self.indirects.first.id
      last_id = self.indirects.last.id
      items = Item.where(category_id: first_id..last_id)
      return items

    elsif self.has_children?
      first_id = self.children.first.id
      last_id = self.children.last.id
      items = Item.where(category_id: first_id..last_id)
      return items

    else
      return self.items
    end
  end
end
