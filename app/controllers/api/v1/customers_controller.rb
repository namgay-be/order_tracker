module Api
  module V1
    class CustomersController < ApplicationController
      def index
        customers = CustomerQuery.new(current_user: current_user, params: query_params).run
        cache_render CustomerSerializer, customers
      end

      def create
        create_customer_form(customer_creator)
      end

      def update
        update_customer_form(customer_updater)
      end

      def show
        cache_render CustomerSerializer, customer
      end

      def destroy
        customer.destroy!
        head :no_content
      end

      def auto_complete
        customers = CustomerAutoCompleteQuery.new(current_user: current_user, params: query_params).run
        cache_render CustomerSerializer, customers
      end

      private

      def customer
        @customer ||= Customer.find(params['id'])
      end

      def customer_creator
        CustomerCreator.new(current_user: current_user, params: customer_params)
      end

      def customer_updater
        CustomerUpdater.new(current_user: current_user, params: customer_params)
      end

      def customer_params
        params.require(:customer).permit(
          :id,
          :name,
          :designation,
          :organisation,
          :status,
          :address
        )
      end

      def query_params
        params.permit(:query, :name)
      end
    end
  end
end