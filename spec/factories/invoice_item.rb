FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.within(range: 1..200) }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    item
    invoice
  end
end