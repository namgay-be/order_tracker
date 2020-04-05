FactoryBot.define do
  factory :foreign_seed_info do
    crop_name { 'foreign crop' }
    genus { 'foreign genus' }
    family { 'foreign family' }
    species { 'foreign species' }
    sub_texa { 'foreign sub texa' }
    material_type { 'foreign material type' }
    classification { 'foreign classification' }
    characteristics { 'foreign characteristics' }
  end
end
