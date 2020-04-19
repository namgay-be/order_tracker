FactoryBot.define do
  factory :gene_bank do
    packaging_date { 10.minutes.from_now }
    accession_number { 'BTNSeed101' }
  end
end
