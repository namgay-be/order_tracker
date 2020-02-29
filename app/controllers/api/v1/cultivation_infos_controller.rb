module Api
  module V1
    class CultivationInfosController < ApplicationController
      def index
        cultivation_infos = CultivationInfoQuery.new(current_user: current_user, params: query_params).run
        cache_render CultivationInfoSerializer, cultivation_infos
      end

      private

      def query_params
        params.permit(:name, :query)
      end
    end
  end
end
