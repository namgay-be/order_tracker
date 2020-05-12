class CustomerAutoCompleteQuery < ApplicationQuery
  attr_accessor :name, :query

  PERMITTED_ATTRIBUTES = %w[
    cust_id
    name
    designation
    organisation
    status
    address
   ].freeze

  def run
    customers
      .yield_self { |customers| search_by_attribute(customers) }
  end

  private

  def search_by_attribute(customers)
    return customers if query.blank?

    customers.search_by_name(attribute_name, query)
  end

  def customers
    Customer.all
  end

  def attribute_name
    name.presence_in(PERMITTED_ATTRIBUTES) || :name
  end
end
