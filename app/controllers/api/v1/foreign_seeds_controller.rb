module Api
  module V1
    class ForeignSeedsController < ApplicationController
      def create
        create_foreign_seed_form(foreign_seed_creator)
      end

      def update
        update_foreign_seed_form(foreign_seed_updater)
      end

      def show
        cache_render ForeignSeedSerializer, foreign_seed
      end

      def destroy
        foreign_seed.destroy!
        head :no_content
      end

      private

      def foreign_seed
        @foreign_seed ||= ForeignSeed.find(params['id'])
      end

      def foreign_seed_creator
        ForeignSeedCreator.new(current_user: current_user, params: foreign_seed_params)
      end

      def foreign_seed_updater
        ForeignSeedUpdater.new(current_user: current_user, params: foreign_seed_params)
      end

      def foreign_seed_params
        params.require(:foreign_seed).permit(
          :id,
          :crop_name,
          :genus,
          :family,
          :species,
          :sub_texa,
          :resistant,
          :susceptible,
          :material_type,
          :classification,
          :characteristics,
          repatriation_info_attributes: %i[
            id
            repatriation_number
            repatriation_date
            quantity
            initial_germination_rate
            condition
            donor_accession
            donor_name
            country
            organisation
            web_url
            email_id
            phone
            fax
            remarks
          ]
        )
      end
    end
  end
end
