module Migrations
  class Customer < Base
    def run
      ::Customer.all.destroy_all
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        customer = set_customer(hash)
        if ::Customer.where(name: customer.name).exists?
          cus = ::Customer.find_by(name: customer.name)
          cus.custom_ids << customer.id
          cus.save!
          next
        end

        customer.save!
        customer.update(cust_id: "CUS_#{customer.id}")
      end
      puts 'Success'
    end

    private

    def set_customer(hash)
      ::Customer.new(
        id: hash[:customer_id],
        name: hash[:customer_name].downcase,
        designation: hash[:designation],
        email: hash[:email],
        organisation: hash[:organisation],
        status: hash[:user_status],
        address: hash[:address],
        contact_number: hash[:contact_no],
        country: hash[:country],
        custom_ids: [hash[:customer_id]]
      )
    end
  end
end
