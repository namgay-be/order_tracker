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

      private

      def seed
        @seed ||= Seed.find(params[:id])
      end

      def seed_updater
        SeedUpdater.new(current_user: current_user, params: seed_params)
      end

      def seed_creator
        SeedCreator.new(current_user: current_user, params: seed_params)
      end

      def seed_params
        params.require(:seed).permit(
          :type,
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
            requires_multiplication
          ],
          donor_field_info_attributes: %i[
            id
            latitude
            longitude
            altitude
            soil_culture
            soil_texture
            topography
          ],
          donor_info_attributes: %i[
            id
            donor_name
            house_number
            dzongkhag
            gewog
            dungkhag
            village
          ],
          seed_info_attributes: %i[
            id
            crop_name
            local_name
            local_variety_name
            family
            genus
            species
            sub_texa
            material_type
            classification
            resistant
            susceptible
            sample_status
            seed_status
          ]
        )
      end
    end
  end
end
