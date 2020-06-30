FactoryBot.define do
  factory :credit_card do
    rand_cus="cus_#{SecureRandom.hex(14)}"
    rand_car="car_#{SecureRandom.hex(14)}"
    customer_id {rand_cus}
    card_id {rand_car}
    user
  end
end