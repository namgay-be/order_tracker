module Migrations
  class Base
    attr_accessor :table

    def initialize(csv)
      @table = CSV.parse(csv, headers: true)
    end
  end
end
