module Api
  module V1
    class GamesController < AuthenticatedController

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
          render json: {error: 'The game could not be found'}, status: HTTP_NOT_FOUND
        end
      end

      # POST /games
      def create
        begin
          game = Game.new(game_params)
          game.creator = current_user
          game.save!
          render json: game
        rescue
          render json: {message: 'Something went wrong creating the game',
                        errors: game.errors}, status: HTTP_FORBIDDEN
        end
      end

      private
      def game_params
        params.require(:game).permit(:num_players)
      end
    end
  end
end