FactoryBot.define do
  factory :test_detail do
    germination_rate { 10.0 }
    germination_date { DateTime.current }
    moisture_content { 30.4 }
    moisture_date { DateTime.current + 2.day }
    remarks { 'Some remarks' }
    date_stored { DateTime.current }
  end
end
