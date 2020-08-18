module Api
  module V1
    class ServiceAreasController < ApplicationController
      def index
        render_paginated_collection(
          ServiceAreasQuery.new(current_user: current_user, params: query_params).run,
          ServiceAreaSerializer
        )
      end

      def create
        service_area = ServiceArea.new(service_area_params)
        if service_area.save
          cache_render ServiceAreaSerializer, service_area
        else
          invalid_resource(service_area)
        end
      end

      def update
        if service_area.update(service_area_params)
          cache_render ServiceAreaSerializer, service_area
        else
          invalid_resource(service_area)
        end
      end

      def show
        cache_render ServiceAreaSerializer, service_area
      end

      def destroy
        service_area.destroy!
        head :no_content
      end

      private

      def service_area
        @service_area ||= ServiceArea.find(params['id'])
      end

      def service_area_params
        params.require(:service_area).permit(
          :id,
          :name,
          address_attributes: %i[
            id
            dzongkhag
            gewog
            village
            sector
            latitude
            longitude
            additional_info
          ]
        )
      end

      def query_params
        params.permit(:dzongkhag, :village, :gewog, :query)
      end
    end
  end
end