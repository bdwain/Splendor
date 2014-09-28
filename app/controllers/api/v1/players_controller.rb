module Api
  module V1
    class PlayersController < AuthenticatedController
      include ChipCollection

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
        player = get_player(params[:id])
        if player == nil
          message = "Invalid request"
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

      #POST /players/:player_id/moves
      def make_move
        player = get_player(params[:player_id].to_i)
        status = HTTP_OK
        if player != nil
          game = player.game
          begin
            case move_params[:type]
            when 'chips'
              taken_chips = ChipCollection.new(JSON::parse(move_params[:taken_chips] || "[]"))
              returned_chips = ChipCollection.new(JSON::parse(move_params[:returned_chips] || "[]"))
              game.take_chips(player, taken_chips, returned_chips)
            when 'reserve'
              card = game.get_card_by_id(move_params[:card_id].to_i) || game.get_top_card_of_level(move_params[:card_level].to_i)
              raise "Invalid card" unless card
              returned_chips = ChipCollection.new(JSON::parse(move_params[:returned_chips] || "[]"))
              player.game.reserve_card(player, card, returned_chips)
            when 'buy'
              card = game.get_card_by_id(move_params[:card_id].to_i)
              raise "Invalid card" unless card
              spent_chips = ChipCollection.new(JSON::parse(move_params[:spent_chips] || "[]"))
              game.buy_card(player, card, spent_chips)
            when 'noble'
              noble = game.get_noble_by_id(move_params[:noble_id].to_i)
              raise "Invalid noble" unless noble
              game.choose_noble(player, noble)
            else
              raise "Invalid move"
            end
          rescue JSON::ParserError
            message = "Invalid request"
            status = HTTP_FORBIDDEN
          rescue => e
            message = e.message
            status = HTTP_FORBIDDEN
          end
        else
          message = "Invalid request"
          status = HTTP_FORBIDDEN
        end

        if status == HTTP_OK
          render json: player.game
        else
          render json: {message: message}, status: status
        end
      end

      private
      def get_player(id)
        player = Player.find_by_id(id)
        if player && player.user == current_user
          return player.game.players.find{|p| p.id == id} #use the game's instance because they're different
        else
          return nil
        end
      end

      def move_params
        params.require(:move).permit!
      end
    end
  end
end