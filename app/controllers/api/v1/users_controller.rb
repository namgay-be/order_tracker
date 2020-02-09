module Api
  module V1
    class UsersController < ApplicationController
      def index
        render_paginated_collection(
          UserQuery.new(current_user: current_user, params: query_params).run,
          UserSerializer
        )
      end

      def show
        render json: user
      end

      private

      def user
        @user ||= User.find(params[:id])
      end

      def query_params
        params.permit(:role_filter, :query, :page, :per_page)
      end
    end
  end
end
