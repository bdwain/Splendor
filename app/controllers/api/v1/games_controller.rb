module Api
  module V1
    class GamesController < ApplicationController
      #before_filter :authenticate_user!

      # GET /games
      def index
        render json: Game.all
      end

      # GET /games/:id
      def show
        game = Game.find_by_id(params[:id])
        if game
          render json: game
        else
          render json: {error: 'The game could not be found'}, status: 404
        end
      end

      # POST /games
      def create
        begin
          game = Game.new(game_params)
          game.creator = User.first #TODO: current_user
          game.save!
          render json: game
        rescue
          render json: {error: 'Something went wrong creating the game'}, status: 500
        end
      end

      private
      def game_params
        params.permit(:num_players)
      end
    end
  end
end