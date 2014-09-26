module Api
  module V1
    class PlayersController < AuthenticatedController
      # POST /game/:game_id/players
      def create
        game = Game.find_by_id(params[:game_id])
        if game != nil && game.add_user?(current_user)
          render json: game, status: HTTP_OK
        else
          render json: {error: "Couldn't join the game"}, status: HTTP_FORBIDDEN
        end
      end

      # DELETE /players/:id
      def destroy
        player = Player.find_by_id(params[:id])
        if !player
          message = "Invalid player"
          status = 404
        elsif player.user != current_user
          message = "Can't remove someone else from a game"
          status = HTTP_FORBIDDEN
        elsif !player.game.remove_player?(player)
          message = "The game already started. Can't quit now"
          status = HTTP_FORBIDDEN
        else
          message = "Player quit the game"
          status = HTTP_OK
        end
        
        render json: {
          message: message
        }, status: status
      end
    end
  end
end