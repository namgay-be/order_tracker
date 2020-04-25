class CustomerUpdater < ApplicationForm
  attr_accessor :customer

  def update(id)
    @customer = Customer.find(id)
    @customer.update(params)
  end
end
