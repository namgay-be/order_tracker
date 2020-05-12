module Api
  module V1
    class LocationsController < ApplicationController
      def index
        locations = LocationQuery.new(current_user: current_user, params: query_params).run
        cache_render LocationSerializer, locations
      end

      private

      def query_params
        params.permit(:name, :query)
      end
    end
  end
end