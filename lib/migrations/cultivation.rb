module Migrations
  class Cultivation < Base
    def run
      ::CultivationInfo.destroy_all
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        cultivation = set_cultivation(hash)
        if !cultivation.save
          puts cultivation.errors.messages
        end
      end
      puts 'Success'
    end

    private

    def set_cultivation(hash)
      ::CultivationInfo.new(
        seed_id: hash[:seed_id],
        nursery_month: hash[:nursery_time],
        planting_month: hash[:plant_season],
        harvesting_month: hash[:harvest_season],
        cultivation_practice: hash[:cult_practice],
        crop_system: hash[:crop_system],
        characteristics: hash[:s_status]
      )
    end
  end
end
