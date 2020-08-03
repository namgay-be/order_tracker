module Migrations
  class Collection < Base
    def run
      ::CollectionInfo.destroy_all
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        collection = set_collection(hash)
        collection.save
      end
      puts 'Success'
    end

    private

    def set_collection(hash)
      ::CollectionInfo.new(
        seed_id: hash[:seed_id],
        collection_number: hash[:collection_no],
        collection_date: hash[:collection_date],
        mission_number: hash[:mission_no],
        collection_source: hash[:collection_source],
        collectors_name: hash[:collectors],
        collection_note: hash[:collection_note]
      )
    end
  end
end
