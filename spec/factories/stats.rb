# spec/factories/stats_spec.rb

FactoryBot.define do
  factory :stat do
    time { Faker::Time.between(Time.now - 1, Time.now) }
    value { Faker::Number.decimal(2, 3) }
  end
end
