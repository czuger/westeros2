class GArmiesHiringController < ApplicationController

  def create
    game_board = GGameBoard.find( params[ :g_game_board_id ] )
    ActiveRecord::Base.transaction do
      params[ :armies_to_hire ].each do |_, val|
        # We create the entry for army recruiting
        army = game_board.g_game_board_armies_to_recruit.where( q: val[:q], r: val[:r], h_house_id: val[ :house_id ] ).first_or_initialize
        army.nb_banners = val[ :army_count ]
        army.save!

        # Then we update the token visibility
        token = game_board.g_game_board_tokens_phantom_armies.find_by( q: val[:q], r: val[:r] )
        token_extra_params = token.extra_parameters
        token_extra_params[ :nb_banners ] = val[ :army_count ]
        token.show = true
        token.save!
      end
    end
    head :ok
  end

end

