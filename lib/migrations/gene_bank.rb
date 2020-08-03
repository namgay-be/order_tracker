module Migrations
  class GeneBank < Base
    def run
      ::GeneBank.destroy_all
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        gene_bank = set_gene_bank(hash)
        if !gene_bank.save
          puts gene_bank.errors.messages
        end
      end
      puts 'Success'
    end

    private

    def set_gene_bank(hash)
      ::GeneBank.new(
        seed_id: hash[:seed_id],
        accession_number: hash[:accession_no],
        creator_id: hash[:gb_user_id],
        packaging_date: hash[:packing_date],
        base_collection_attributes: {
          germination_weight: hash[:gv_weight],
          germination_packets: hash[:gv_packet],
          regeneration_weight: hash[:mr_weight],
          regeneration_packets: hash[:mr_packet],
          rest_weight: hash[:r_weight],
          rest_packets: hash[:r_packet],
          locations_attributes: [
            {
              name: hash[:b_location_1]
            },
            {
              name: hash[:b_location_2]
            }
          ]
        },
        characterization_attributes: {
          weight: hash[:c_weight],
          packets: hash[:c_packet],
          location_attributes: {
            name: hash[:c_location]
          }
        },
        duplicate_attributes: {
          weight: hash[:d_weight],
          packets: hash[:d_packets],
          locations_attributes: [
            {
              name: hash[:d_location_1]
            },
            {
              name: hash[:d_location_2]
            }
          ]
        },
        active_collection_attributes: {
          weight: hash[:us_weight],
          packets: hash[:us_packet],
          location_attributes: {
            name: hash[:us_location]
          }
        }
      )
    end
  end
end
