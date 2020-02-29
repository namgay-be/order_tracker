module Api
  module V1
    class SeedInfosController < ApplicationController
      def index
        seed_infos = SeedInfoQuery.new(current_user: current_user, params: query_params).run
        cache_render SeedInfoSerializer, seed_infos
      end

      private

      def query_params
        params.permit(:name, :query)
      end
    end
  end
end
