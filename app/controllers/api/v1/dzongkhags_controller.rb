module Api
  module V1
    class DzongkhagsController < ApplicationController
      def index
        dzongkhags = Dzongkhag.all
        render json: dzongkhags
      end
    end
  end
end
