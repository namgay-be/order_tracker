module Api
  module V1
    class SessionsController < Devise::SessionsController
      include CacheCrispies::Controller

      private

      def respond_with(resource, _opts = {})
        cache_render UserSerializer, resource
      end

      def respond_to_on_destroy
        head :no_content
      end
    end
  end
end
