FactoryBot.define do
  factory :category do
    rand_category_id = Random.rand(159 .. 1330)
    id{rand_category_id}
  end
end