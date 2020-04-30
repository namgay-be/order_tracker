class PacketCount < ApplicationRecord
  belongs_to :gene_bank, inverse_of: :packet_count
end
