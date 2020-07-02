FactoryBot.define do
  factory :repatriation_info do
    repatriation_number { 123456 }
    repatriation_date { DateTime.current }
    quantity { 12 }
    initial_germination_rate { 12 }
    condition { 'very condition' }
    donor_accession { 'some accession' }
    donor_name { 'human donor' }
    country { 'India' }
    organisation { 'some organisation' }
    web_url { 'some web url' }
    email_id { 'nt@gmail.com' }
    phone { '12093243' }
    fax { 'some fax' }
    remarks { 'some remarks' }
  end
end
