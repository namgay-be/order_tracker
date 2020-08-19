module Api
  module V1
    class StoresController < ApplicationController

      def index
        render_paginated_collection(
          StoresQuery.new(current_user: current_user, params: query_params).run,
          StoreListSerializer
        )
      end

      def create
        store = Store.new(store_params)
        if store.save
          cache_render StoreSerializer, store
        else
          invalid_resource(store)
        end
      end

      def update
        if store.update(store_params)
          cache_render StoreSerializer, store
        else
          invalid_resource(store)
        end
      end

      def show
        cache_render StoreSerializer, store
      end

      def destroy
        store.destroy!
        head :no_content
      end

      private

      def store
        @store ||= Store.find(params['id'])
      end

      def store_params
        params.require(:store).permit(
          :id,
          :name,
          :category,
          :phone_1,
          :phone_2,
          :email,
          :available,
          :service_area_id,
          address_attributes: %i[
            id
            dzongkhag
            gewog
            village
            sector
            latitude
            longitude
            additional_info
            _destroy
          ],
          contacts_attributes: %i[
            id
            name
            phone
            contact_type
            _destroy
          ],
          items_attributes: [
            :id,
            :name,
            :price,
            :available,
            :additional_info,
            :_destroy,
            photos_attributes: [
              :id,
              :image,
              :_destroy
            ]
          ],
          photos_attributes: %i[
            id
            image
            _destroy
          ]
        )
      end

      def query_params
        params.permit(:dzongkhag, :village, :gewog, :query, :category, :page, :per_page)
      end
    end
  end
end