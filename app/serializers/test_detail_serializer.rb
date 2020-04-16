class TestDetailSerializer < ApplicationSerializer
  key :test_detail
  collection_key :test_details
  serialize(
    :id,
    :germination_rate,
    :germination_date,
    :moisture_content,
    :moisture_date,
    :date_stored,
    :remarks
  )
end