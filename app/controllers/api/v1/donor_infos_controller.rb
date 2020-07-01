module Api
  module V1
    class DonorInfosController < ApplicationController
      def index
        donor_infos = DonorInfoQuery.new(current_user: current_user, params: query_params).run
        cache_render DonorInfoSerializer, donor_infos
      end

      def create
        create_donor_info_form(donor_info_creator)
      end

      def update
        update_donor_info_form(donor_info_updater)
      end

      def show
        cache_render DonorInfoSerializer, donor_info
      end

      def destroy
        donor_info.destroy
        head :no_content
      end

      private

      def donor_info
        @donor_info ||= DonorInfo.find(params[:id])
      end

      def donor_info_creator
        DonorInfoCreator.new(params: donor_info_params, current_user: current_user)
      end

      def donor_info_updater
        DonorInfoUpdater.new(params: donor_info_params, current_user: current_user)
      end

      def donor_info_params
        params.require(:donor_info).permit(
          :donor_name,
          :house_number,
          :dzongkhag,
          :gewog,
          :village,
          :dungkhag,
          :latitude,
          :longitude,
          :altitude,
          :soil_color,
          :soil_texture
        )
      end

      def query_params
        params.permit(:name, :query)
      end
    end
  end
end
