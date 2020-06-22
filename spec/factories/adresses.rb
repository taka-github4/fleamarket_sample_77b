FactoryBot.define do
  factory :address do
    rand_first_name_kana=8.times.inject("") { |str| str.concat([*"ぁ".."ん"].sample) }
    rand_last_name_kana=8.times.inject("") { |str| str.concat([*"ぁ".."ん"].sample) }
    rand_zip_code = Random.rand( 10010 .. 9998531 )
    rand_prefecture = Random.rand( 1 .. 47 )
    rand_house_number = Faker::Address.street_name + "#{Random.rand ( 1 .. 30 )}-#{Random.rand ( 1 .. 30 )}"
    rand_apartment = Faker::Ancient.god + Faker::Address.building_number + "号室"
    rand_user_id = Random.rand( 1 .. 100 )
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    first_name_kana {rand_first_name_kana}
    last_name_kana {rand_last_name_kana}
    zip_code {rand_zip_code}
    prefecture {rand_prefecture}
    city {Faker::Address.city}
    house_number {rand_house_number}
    apartment{rand_apartment}
  end
end