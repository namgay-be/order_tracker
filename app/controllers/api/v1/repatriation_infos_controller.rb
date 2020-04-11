module Api
  module V1
    class RepatriationInfosController < ApplicationController
      def index
        repatriation_infos = RepatriationInfoQuery.new(current_user: current_user, params: query_params).run
        cache_render RepatriationInfoSerializer, repatriation_infos
      end

      private

      def query_params
        params.permit(:name, :query)
      end
    end
  end
end
