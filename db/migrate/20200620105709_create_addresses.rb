class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_name,       null: false
      t.string :last_name,        null: false
      t.string :first_name_kana,  null: false
      t.string :last_name_kana,   null: false
      t.integer :zip_code,        null: false
      t.integer :prefecture,      null: false, default: 0
      t.string :city,             null: false
      t.string :house_number,     null: false
      t.string :apartment
      t.references :user,         null: false, oreign_key: true
      t.timestamps
    end
  end
end