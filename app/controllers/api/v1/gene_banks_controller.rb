module Api
  module V1
    class GeneBanksController < ApplicationController
      def create
        create_gene_bank_form(gene_bank_creator)
      end

      def update
        update_gene_bank_form(gene_bank_updater)
      end

      def show
        cache_render GeneBankSerializer, gene_bank
      end

      def destroy
        gene_bank.destroy!
        head :no_content
      end

      private

      def gene_bank
        @gene_bank ||= GeneBank.find(params['id'])
      end

      def gene_bank_creator
        GeneBankCreator.new(current_user: current_user, params: gene_bank_params)
      end

      def gene_bank_updater
        GeneBankUpdater.new(current_user: current_user, params: gene_bank_params)
      end

      def gene_bank_params
        params.require(:gene_bank).permit(
          :id,
          :seed_id,
          :accession_number,
          :packaging_date,
          base_collection_attributes: [
            :germination_weight,
            :germination_packets,
            :regeneration_weight,
            :regeneration_packets,
            :rest_weight,
            :rest_packets,
            :_destroy,
            locations_attributes: %i[
              name
              _destroy
            ]
          ],
          active_collection_attributes: [
            :weight,
            :packets,
            :_destroy,
            location_attributes: %i[
              name
              _destroy
            ]
          ],
          characterization_attributes: [
            :weight,
            :packets,
            :_destroy,
            location_attributes: %i[
              name
              _destroy
            ]
          ],
          duplicate_attributes: [
            :weight,
            :packets,
            :_destroy,
            locations_attributes: %i[
              name
              _destroy
            ]
          ]
        )
      end
    end
  end
end