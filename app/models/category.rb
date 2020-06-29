class Category < ApplicationRecord
  has_many :items
  has_ancestry

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