module Migrations
  class Dzongkhag < Base
    def run
      ::Dzongkhag.all.destroy_all
      table.each do |row|
        hash = HashWithIndifferentAccess.new(row.to_h)
        dzongkhag = ::Dzongkhag.new(id: hash[:dzongkhag_id], name: hash[:dzongkhag_name])
        dzongkhag.save!
      end
      puts 'Success'
    end
  end
end
