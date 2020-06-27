module Api
  module V1
    class DistributionInfosController < ApplicationController
      def index
        render_paginated_collection(
          DistributionInfoQuery.new(current_user: current_user, params: query_params).run,
          DistributionInfoSerializer
        )
      end

      def show
        cache_render DistributionInfoSerializer, distribution_info
      end

      def create
        create_distribution_info_form(distribution_info_creator)
      end

      def update
        update_distribution_info_form(distribution_info_updater)
      end

      def destroy
        DistributionInfoDestroyer.new(distribution_info).run
        head :no_content
      end

      def auto_complete
        distribution_infos = DistributionAutoCompleteQuery.new(
          current_user: current_user, params: autocomplete_params).run
        cache_render DistributionInfoSerializer, distribution_infos
      end

      def finalize
        if DistributionInfoFinalizer.new(current_user: current_user, params: finalize_params).run
          render json: { message: 'success' }
        else
          render json: { message: 'failed', status: 400 }
        end
      end

      private

      def distribution_info
        @distribution_info ||= DistributionInfo.find(params[:id])
      end

      def distribution_info_creator
        DistributionInfoCreator.new(current_user: current_user, params: distribution_info_params)
      end

      def distribution_info_updater
        DistributionInfoUpdater.new(current_user: current_user, params: distribution_info_params)
      end

      def distribution_info_params
        params.require(:distribution_info).permit(
          :id,
          :customer_id,
          :seed_id,
          :requested_date,
          :supplied_date,
          :package_type,
          :quantity,
          :purpose,
          :remarks,
          locations_attributes: %i[
            id
            name
            _destroy
          ]
        )
      end

      def query_params
        params.permit(:query, :package_type, :customer_id, :seed_id)
      end

      def autocomplete_params
        params.permit(:query, :name)
      end

      def finalize_params
        params.require(:distribution_info).permit(distribution_ids: [])
      end
    end
  end
end