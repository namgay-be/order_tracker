module Migrations
  class DonorField < Base
    def run
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        donor = DonorInfo.where('custom_ids && ?', "{#{hash[:donor_id]}}")
        update_donor(hash, donor.take) if donor.exists?
      end
      puts 'Success'
    end

    private

    def update_donor(hash, donor)
      donor.update!(
        latitude: hash[:latitude],
        longitude: hash[:longitude],
        altitude: hash[:altitude],
        topography: hash[:topography],
        soil_color: hash[:soil_colour],
        soil_texture: hash[:soil_texture]
      )
    end
  end
end
