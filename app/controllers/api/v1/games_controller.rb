module Api
  module V1
    class GamesController < ApplicationController
      #before_filter :authenticate_user!

      # GET /games
      def index
        render json: Game.all
      end
    end
  end
end