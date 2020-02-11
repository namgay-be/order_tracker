module Api
  module V1
    class InvitationsController < Devise::InvitationsController
      private

      def respond_with(resource, _opts = {})
        cache_render UserSerializer, resource
      end
    end
  end
end
