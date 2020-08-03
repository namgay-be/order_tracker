module Api
  module V1
    class GewogsController < ApplicationController
      def index
        gewogs = Gewog.where(dzongkhag_id: params[:dzongkhag_id])
        render json: gewogs
      end
    end
  end
end
