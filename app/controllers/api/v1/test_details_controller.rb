module Api
  module V1
    class TestDetailsController < ApplicationController
      def create
        create_test_detail_form(test_details_creator)
      end

      def update
        update_test_detail_form(test_details_updater)
      end

      def show
        cache_render TestDetailSerializer, test_detail
      end

      def destroy
        test_detail.destroy!
        head :no_content
      end

      private

      def test_detail
        @test_detail ||= TestDetail.find(params['id'])
      end

      def test_details_creator
        TestDetailsCreator.new(current_user: current_user, params: test_detail_params)
      end

      def test_details_updater
        TestDetailsUpdater.new(current_user: current_user, params: test_detail_params)
      end

      def test_detail_params
        params.require(:test_detail).permit(
          :id,
          :seed_id,
          :germination_rate,
          :germination_date,
          :moisture_content,
          :moisture_date,
          :date_stored,
          :remarks
        )
      end
    end
  end
end