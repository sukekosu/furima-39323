FactoryBot.define do
  factory :order_address do
    token { "tok_abcdefghijk00000000000000000" }
    post_code { '123-4567' }
    ship_from_id { "3" }
    city { '横浜' }
    address { '青山' }
    building_name { 'ハイツ' }
    tel_num { '09012345678' }
  end
end