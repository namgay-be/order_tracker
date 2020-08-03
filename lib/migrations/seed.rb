module Migrations
  class Seed < Base
    STATUS_HASH = { '0': 'under_process', '0.1': 'under_process', '1': 'tested', '2': 'transferred', '3': 'distributed' }

    def run
      ::Seed.all.destroy_all
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        seed = set_seed(hash)
        seed.save!
      end
      puts 'Success'
    end

    private

    def set_seed(hash)
      ::Seed.new(
        id: hash[:seed_id],
        type: seed_type(hash),
        crop_name: hash[:crop_name],
        family: hash[:family],
        genus: hash[:genus],
        species: hash[:species],
        sub_texa: hash[:sub_texa],
        material_type: hash[:material_type],
        classification: hash[:classification],
        resistant: hash[:resistant],
        susceptible: hash[:susceptible],
        seed_status: STATUS_HASH[:"#{hash[:samplestatus_id]}"],
        requires_multiplication: multiplication_required(hash),
        donor_info_id: donor_id(hash),
        creator_id: creator_id(hash),
        old_data: true,
        rep_id: custom_id(hash),
        seed_info_attributes: {
          local_name: hash[:local_name],
          local_variety_name: hash[:localvariety_name]
        }
      )
    end

    def custom_id(hash)
      hash[:type] == 'repatriation' ? hash[:donor_id] : nil
    end

    def creator_id(hash)
      hash[:p_user_id] == '0' ? nil : hash[:p_user_id]
    end

    def donor_id(hash)
      return nil if hash[:type] == 'repatriation'

      donor = DonorInfo.where('custom_ids && ?', "{#{hash[:donor_id]}}")
      donor.take.try(:id)
    end

    def multiplication_required(hash)
      hash[:samplestatus_id] == '0.1' ? true : false
    end

    def seed_type(hash)
      hash[:type] == 'passport' ? nil : 'ForeignSeed'
    end

    def nill_values
      ['Nil', 'NIl', 'NIL', 'Nill', 'Nk', 'nil']
    end
  end
end
