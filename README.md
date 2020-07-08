## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|size|integer||
|description|text|null: false|
|item_condition|integer|null: false|
|burden|integer|null: false|
|prefectures|integer|null: false|
|days|integer|null: false|
|brand|integer|null: false|
|category_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|
### Asociation
- has_many :comments
- belongs_to :user
- has_many :photos
- belongs_to :category
- has_many :favorites

## categoryテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||
## Asociation
- has_many :items
- has_ancestry

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|password_confirmation|string|null: false|
|birthday|date|null: false|
### Asociation
- has_many :items, dependent: :destroy
- has_many :comments, dependent:destroy
- has_one :address, dependent: :destroy
- has_one :credit_card, dependent: :destroy
- has_many :favorites, dependent: :destroy

## addressesテーブル

|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|zip_code|integer|null:false|
|prefecture|integer|null:false|
|city|string|null: false|
|house_number|string|null: false|
|apartment|string||
|user_id|references|null: false, foreign_key: true|
### Asociation
- belongs_to :user

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|content|text|null: false|
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
### Asociation
- belongs_to: user
- belongs_to: item

## photosテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|references|null: false, foreign_key: true|
### Asociation
- belongs_to: item

## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|credit_number|integer|null: false, unique: true|
|deadline_year|integer|null: false|
|deadline_month|integer|null: false|
|security_code|integer|null: false|
|user_id|references|null: false, foreign_key: true|
### Asociation
- belongs_to :user

## favoritesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false|
|item_id|refarences|null: false|
### Asociation
- belongs_to: user
- belongs_to: item

