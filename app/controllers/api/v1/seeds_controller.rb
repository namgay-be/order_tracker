module Api
  module V1
    class SeedsController < ApplicationController
      def create
        create_seed_form(seed_creator)
      end

      def update
        update_seed_form(seed_updater)
      end

      def show
        cache_render SeedSerializer, seed
      end

      def destroy
        seed.destroy!
        head :no_content
      end

      def index
        render_paginated_collection(
          SeedsQuery.new(current_user: current_user, params: query_params).run,
          SeedListSerializer
        )
      end

      def export
        seeds = SeedsQuery.new(current_user: current_user, params: query_params).run
        exporter = SeedExporter.new(seeds: seeds, type: query_params['type'])
        if exporter.valid?
          render json: { blob: rails_blob_path(exporter.export, disposition: 'attachment') }
        else
          invalid_resource(exporter)
        end
      end

      def auto_complete
        seeds = SeedAutocompleteQuery.new(current_user: current_user, params: auto_complete_params).run
        cache_render SeedSerializer, seeds
      end

      def list
        render_paginated_collection(
          SeedsListQuery.new(current_user: current_user, params: query_params).run,
          SeedListSerializer
        )
      end

      def parse_excel
        seeds = ExcelParser.new(current_user: current_user, params: excel_params).run
        cache_render SeedListSerializer, seeds
      end

      def templates
        send_file(Rails.root.join('lib', 'templates', "#{file_type}_seed_template.xlsx"))
      end

      def batch_delete
        seeds = Seed.where(id: seed_id_params[:seed_ids])
        seeds.destroy_all
        head :no_content
      end

      def disqualify
        seed.reject!
        cache_render SeedSerializer, seed
      end

      private

      def seed
        @seed ||= Seed.find(params[:id])
      end

      def seed_updater
        SeedUpdater.new(current_user: current_user, params: seed_params, donor_params: donor_info_params)
      end

      def seed_creator
        SeedCreator.new(current_user: current_user, params: seed_params, donor_params: donor_info_params)
      end

      def query_params
        params.permit(
          :query,
          :crop_name,
          :local_name,
          :local_variety,
          :status,
          :donor,
          :dzongkhag,
          :gewog,
          :classification,
          :type,
          :minimum_altitude,
          :maximum_altitude,
          :requires_multiplication,
          :banned
        )
      end

      def auto_complete_params
        params.permit(:name, :query)
      end

      def seed_params
        params.require(:seed).permit(
          :type,
          :family,
          :genus,
          :species,
          :sub_texa,
          :material_type,
          :classification,
          :resistant,
          :susceptible,
          :crop_name,
          :seed_status,
          :requires_multiplication,
          :donor_info_id,
          :banned,
          collection_info_attributes: %i[
            id
            mission_number
            collection_number
            collection_source
            collectors_name
            collection_note
            collection_date
          ],
          cultivation_info_attributes: %i[
            id
            nursery_month
            planting_month
            harvesting_month
            cultivation_practice
            crop_system
            characteristics
          ],
          seed_info_attributes: %i[
            id
            local_name
            local_variety_name
            sample_status
          ]
        )
      end

      def donor_info_params
        if params['donor_info'].nil?
          {}
        else
          params.require(:donor_info).permit(
            :donor_name,
            :house_number,
            :gewog_id,
            :village,
            :dungkhag,
            :latitude,
            :longitude,
            :altitude,
            :soil_color,
            :soil_texture
          )
        end
      end

      def excel_params
        params.require(:seed).permit(:name, :file)
      end

      def file_type
        params[:file].presence_in(%w[local cryo foreign]) || 'local'
      end

      def seed_id_params
        params.permit(seed_ids: [])
      end
    end
  end
end
