class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,                null: false
      t.integer :price,              null: false
      t.integer :size_id
      t.text :description,           null: false
      t.integer :item_condition_id,  null: false, default: 0
      t.integer :burden_id,          null: false, default: 0
      t.integer :prefectures_id,     null: false, default: 0
      t.integer :days_id,            null: false, default: 0
      t.string :brand
      t.integer :purchaser_id
      t.references :category,     null: false, foreign_key: true
      t.references :user,         null: false, foreign_key: true
      t.timestamps
    end
  end
end