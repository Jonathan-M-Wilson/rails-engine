FactoryBot.define do
  factory :item do
    name { Faker::Games::Zelda.item }
    description { Faker::GreekPhilosophers.quote}
    unit_price { Faker::Number.decimal(l_digits: 2)}
    created_at { Time.zone.today }
    updated_at { Time.zone.today }
    merchant
  end
end
