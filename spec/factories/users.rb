FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.first_name }
    email                 { Faker::Internet.free_email }
    password              { '1Aa' + Faker::Internet.password(min_length: 6, mix_case: true) }
    password_confirmation { password }
    family_name           { '高橋' }
    first_name            { '直希' }
    kana_family_name      { 'タカハシ' }
    kana_first_name       { 'ナオキ' }
    birthday              { Faker::Date.birthday(min_age: 12, max_age: 70) }
  end
end
