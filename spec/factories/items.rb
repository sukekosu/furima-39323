FactoryBot.define do
  factory :item do
    name { Faker::Lorem.sentence }
    describe { Faker::Lorem.sentence }
    price { 1000 }
    category_id { 1 }
    status_id { 1 }
    delv_fee_id { 1 }
    ship_from_id { 1 }
    delv_days_id { 1 }
    association :user
  end
end