module Api
  module V1
    class DonorInfosController < ApplicationController
      def index
        donor_infos = DonorInfoQuery.new(current_user: current_user, params: query_params).run
        cache_render DonorInfoSerializer, donor_infos
      end

      private

      def query_params
        params.permit(:name, :query)
      end
    end
  end
end
