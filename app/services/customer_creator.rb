class CustomerCreator < ApplicationForm
  attr_accessor :customer

  def create
    @customer = Customer.new(params)
    @customer.assign_attributes(creator: current_user)
    @customer.save.tap { set_cust_id }
  end

  private

  def set_cust_id
    customer.update(cust_id: "CUS_#{customer.id}")
  end
end
