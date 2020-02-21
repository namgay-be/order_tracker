FactoryBot.define do
  factory :seed_info do
    crop_name { 'crop1' }
    local_name { 'local1' }
    local_variety_name { 'variety1' }
    family { 'family1' }
    genus { 'genus1' }
    species { 'species1' }
    sub_texa { 'sub_texa1' }
    material_type { 'material1' }
    classification { 'classification1' }
    resistant { 'resistant1' }
    susceptible { 'susceptible1' }
    sample_status { 'status1' }
    seed_status { 'seed1' }
  end
end
