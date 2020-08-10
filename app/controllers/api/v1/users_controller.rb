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

      def soft_delete
        update_user_form(user_deleter)
      end

      private

      def user_updater
        UserUpdater.new(current_user: current_user, params: update_params)
      end

      def user_deleter
        UserDeleter.new(current_user: current_user, params: soft_delete_params)
      end

      def user
        @user ||= User.find(params[:id])
      end

      def update_params
        params.require(:user).permit(:email, :designation, :phone, :name, :username, :image, :role_id)
      end

      def soft_delete_params
        params.require(:user).permit(:deleted_at)
      end

      def query_params
        params.permit(:role_filter, :query, :page, :per_page)
      end
    end
  end
end
