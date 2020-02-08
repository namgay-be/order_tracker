module Api
  module V1
    class PasswordsController < Devise::PasswordsController
      def create
        setter = PasswordSetter.new(resource_params, resource_class)
        if setter.save
          render json: { message: [I18n.t('mailers.password_reset.reset_link_sent')] }
        else
          invalid_resource(setter)
        end
      end

      def update
        updater = PasswordUpdater.new(password_params, resource_class)
        if updater.update
          render json: { message: [I18n.t('devise.passwords.updated_not_active')] }
        else
          invalid_resource(updater)
        end
      end

      private

      def send_instructions
        resource_class.send_reset_password_instructions(resource_params)
      end

      def password_params
        resource_params.permit(
          :reset_password_token,
          :password,
          :password_confirmation
        )
      end
    end
  end
end
