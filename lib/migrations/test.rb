module Migrations
  class Test < Base
    def run
      ::TestDetail.destroy_all
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        test_data = set_test_data(hash)
        if !test_data.save
          puts test_data.errors.messages
        end
      end
      puts 'Success'
    end

    private

    def set_test_data(hash)
      ::TestDetail.new(
        germination_rate: germination_rate(hash),
        germination_date: hash[:germination_date],
        moisture_content: moisture_content(hash),
        moisture_date: hash[:moisturetest_date],
        date_stored: hash[:t_stored_date],
        remarks: hash[:remarks],
        seed_id: hash[:seed_id],
        creator_id: hash[:t_user_id]
      )
    end

    def germination_rate(hash)
      if hash[:germination_rate].to_f <= 1000
        hash[:germination_rate]
      else
        999
      end
    end

    def moisture_content(hash)
      if hash[:moisture_content].to_f <= 1000
        hash[:moisture_content]
      else
        999
      end
    end
  end
end
