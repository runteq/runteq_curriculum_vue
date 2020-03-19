FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "example-#{n}@example.com" }
    password { '12345678' }
    password_confirmation { '12345678' }
    sequence(:name) { |n| "#{n}さん" }
  end
end
