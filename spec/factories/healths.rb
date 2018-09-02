FactoryBot.define do
  factory :health  do
    time { Faker::Time.between(Time.now - 1, Time.now) }
    value { Faker::Boolean.boolean(1.0) }
  end
end
