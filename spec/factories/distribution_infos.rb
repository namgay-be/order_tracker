FactoryBot.define do
  factory :distribution_info do
    requested_date { DateTime.current }
    supplied_date { DateTime.current }
    quantity { 10 }
  end
end
