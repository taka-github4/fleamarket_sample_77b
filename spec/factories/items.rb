FactoryBot.define do
  factory :item do
    name {Faker::Games::Pokemon.name}
    rand_price = Random.rand( 300 .. 9999999 )
    price{rand_price}
    rand_size_id = Random.rand(1..6)
    size_id{rand_size_id}
    rand_description=1000.times.inject("") { |str| str.concat([*"ぁ".."ん"].sample) }
    description{rand_description}
    rand_item_condition_id = Random.rand(1 .. 6)
    item_condition_id{rand_item_condition_id}
    rand_burden_id = Random.rand(1 .. 2)
    burden_id{rand_burden_id}
    rand_prefectures_id = Random.rand( 1 .. 47 )
    prefectures_id{rand_prefectures_id}
    rand_days_id = Random.rand(1 .. 3)
    days_id{rand_days_id}
    rand_brand=5.times.inject("") { |str| str.concat([*"ぁ".."ん"].sample) }
    brand{rand_brand}
    rand_purchaser_id = Random.rand(1 .. 99)
    purchaser_id{rand_purchaser_id}
    rand_category_id = Random.rand(159 .. 1000)
    category
    user
  end
end