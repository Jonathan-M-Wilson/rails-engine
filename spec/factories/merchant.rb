FactoryBot.define do
  factory :merchant do
    name { Faker::TvShows::Stargate.planet }
    created_at { Time.zone.today }
    updated_at { Time.zone.today }
  end
end
