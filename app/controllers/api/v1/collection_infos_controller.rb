module Api
  module V1
    class CollectionInfosController < ApplicationController
      def index
        collection_infos = CollectionInfoQuery.new(current_user: current_user, params: query_params).run
        cache_render CollectionInfoSerializer, collection_infos
      end

      private

      def query_params
        params.permit(:name, :query)
      end
    end
  end
end
