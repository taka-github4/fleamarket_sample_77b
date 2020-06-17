## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|category_id|integer|null: false|
|size_id|integer||
|description|text|null: false|
|item_condition_id|integer|null: false|
|負担_id|integer|null: false|
|都道府県_id|integer|null: false|
|日数_id|integer|null: false|
|brand|integer|null: false|
### Asociation
- has_many :comments
- belongs_to :user
- has_many :photos

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false｜
|email|string|null: false, unique: true|
|password|string|null: false|
|password_confirmation|string|null: false|
### Asociation
- has_many :items
- has_many :comments
- has_many :photos
- has_one :addres
## addressテーブル

|Column|Type|Options|
|------|----|-------|
|destination_first_name|string|null: false|
|destination_last_name|string|null: false|
|destination_first_name_kana|string|null: false|
|destination_last_name_kana|string|null: false|
|zip_code|integer|null:f alse|
|prefecture|integer|null:false|
|city|string|null: false|
|番地|string|null: false|
|マンション|string||
|phone_number|integer||
|use_id|reference|null: false, foureign_key: true|
### Asociation
- belongs_to :user

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|text|null: false|
|created_at|timestamp|null: false|
|user_id|reference|null: false, foreign_key: true|
|item_id|reference|null: false, foregin_key: true|
### Asociation
- 

## photosテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|integer||
### Asociation
- 
