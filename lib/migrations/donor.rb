module Migrations
  class Donor < Base
    def run
      ::DonorInfo.all.destroy_all
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        next if (hash[:donor_name].blank? || nill_values.include?(hash[:donor_name]))

        donor = set_donor(hash)
        donor.custom_ids << hash[:donor_id]
        if ::DonorInfo.where(donor_name: donor.donor_name, village: donor.village).exists?
          existing_donor = DonorInfo.find_by(donor_name: donor.donor_name, village: donor.village)
          existing_donor.custom_ids << hash[:donor_id]
          existing_donor.save
          next
        end
        if !donor.save
          puts donor.errors.message
          puts hash
        end

      end
      puts 'Success'
    end

    private

    def set_donor(hash)
      ::DonorInfo.new(
        donor_name: hash[:donor_name],
        house_number: hash[:house_number],
        dungkhag: hash[:dungkhag],
        village: hash[:village_name],
        gewog_id: gewog_id(hash),
        creator_id: creator_id(hash)
      )
    end

    def creator_id(hash)
      hash[:do_user_id] == '0' ? nil : hash[:do_user_id]
    end

    def gewog_id(hash)
      hash[:gewog_id] == '0' ? nil : hash[:gewog_id]
    end

    def nill_values
      ['Nil', 'NIl', 'NIL', 'Nill', 'Nk', 'nil']
    end
  end
end
