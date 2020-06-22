FactoryBot.define do
  factory :user do
    rand_first_name_kana=8.times.inject("") { |str| str.concat([*"ぁ".."ん"].sample) }
    rand_last_name_kana=8.times.inject("") { |str| str.concat([*"ぁ".."ん"].sample) }
    start_date = Date.parse("1930/01/01")
    end_date = Date.parse("2002/12/31")
    rand_date = Random.rand( start_date .. end_date )
    rand_password = Faker::Internet.password(min_length: 7)
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    first_name_kana {rand_first_name_kana}
    last_name_kana {rand_last_name_kana}
    nickname {Faker::Games::Pokemon.name}
    birthday {rand_date}
    password {rand_password}
    password_confirmation {rand_password}
  end
end