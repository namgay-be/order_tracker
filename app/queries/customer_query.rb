class CustomerQuery < ApplicationQuery
  attr_accessor :query

  def run
    customers.search(query)
  end

  private

  def customers
    Customer.all
  end
end