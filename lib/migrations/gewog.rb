module Migrations
  class Gewog < Base
    def run
      ::Gewog.all.destroy_all
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        gewog = ::Gewog.new(id: hash[:gewog_id], name: hash[:gewog_name], dzongkhag_id: hash[:dzongkhag_id])
        gewog.save!
      end
      puts 'Success'
    end
  end
end
