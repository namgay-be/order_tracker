module Api
  module V1
    class UsersController < ApplicationController
      include CacheCrispies::Controller

      def index
        authorize(User)
        render_paginated_collection(
          UserQuery.new(current_user: current_user, params: query_params).run,
          UserSerializer
        )
      end

      def show
        cache_render UserSerializer, user
      end

      def update
        update_user_form(user_updater)
      end

      private

      def user_updater
        UserUpdater.new(current_user: current_user, params: user_params)
      end

      def user
        @user ||= User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :designation, :phone, :name, :username, :image)
      end

      def query_params
        params.permit(:role_filter, :query, :page, :per_page)
      end
    end
  end
end
