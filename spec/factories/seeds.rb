FactoryBot.define do
  factory :seed do
    type { nil }
    crop_name { 'crop1' }
    family { 'family1' }
    genus { 'genus1' }
    species { 'species1' }
    sub_texa { 'sub_texa1' }
    material_type { 'material1' }
    classification { 'classification1' }
    resistant { 'resistant1' }
    susceptible { 'susceptible1' }
  end
end
