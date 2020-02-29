module Api
  module V1
    class DonorFieldInfosController < ApplicationController
      def index
        donor_field_infos = DonorFieldInfoQuery.new(current_user: current_user, params: query_params).run
        cache_render DonorFieldInfoSerializer, donor_field_infos
      end

      private

      def query_params
        params.permit(:name, :query)
      end
    end
  end
end
