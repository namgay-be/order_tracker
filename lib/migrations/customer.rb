module Migrations
  class Customer < Base
    def run
      ::Customer.all.destroy_all
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        customer = set_customer(hash)
        next if ::Customer.where(name: customer.name).exists?

        customer.save!
        customer.update(cust_id: "CUS_#{customer.id}")
      end
      puts 'Success'
    end

    private

    def set_customer(hash)
      ::Customer.new(
        name: hash[:customer_name],
        designation: hash[:designation],
        email: hash[:email],
        organisation: hash[:organisation],
        status: hash[:user_status],
        address: hash[:address],
        contact_number: hash[:contact_no],
        country: hash[:country]
      )
    end
  end
end
