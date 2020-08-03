FactoryBot.define do
  factory :donor_info do
    donor_name { 'donor1' }
    house_number { Faker::Number.normal }
    gewog_id { Gewog.first.id }
    dungkhag { 'dungkhag1' }
    village { 'village1' }
    latitude { '12klj43kj' }
    longitude { '23423gf' }
    altitude { 100.1 }
    soil_color { 'culture1' }
    soil_texture { 'texture1' }
    topography { 'topography1' }
    custom_donor_id { 'DONOR_1'}
  end
end
