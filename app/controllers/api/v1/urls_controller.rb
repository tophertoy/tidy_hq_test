module Api
  module V1
    class UrlsController < ApplicationController
      before_action :authenticate

      def index
        urls = Url.all
        render json: urls.as_json(only: [:id, :original_url, :short_url, :expires_at, :click_count]), status: :ok
      end

      def show
        # this should possibly be short_url similar to the controller
        url = Url.find_by!(id: params[:id])
        render json: url.as_json(only: [:id, :original_url, :short_url, :expires_at, :click_count]), status: :ok
      end

      private

      def authenticate
        authenticate_or_request_with_http_basic do |username, password|
          username == ENV['API_USERNAME'] && password == ENV['API_PASSWORD']
        end
      end
    end
  end
end
