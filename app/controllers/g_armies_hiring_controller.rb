class GArmiesHiringController < ApplicationController

  def create
    game_board = GGameBoard.find( params[ :g_game_board_id ] )
    ActiveRecord::Base.transaction do
      params[ :armies_to_hire ].each do |_, val|
        army = game_board.g_game_board_armies.where( q: val[:q], r: val[:r] ).first_or_initialize
        if army.class == Armies::ToRecruit && army.h_house_id == val[ :house_id ].to_i
          if army.nb_banners != val[ :army_count ].to_i
            army.nb_banners = val[ :army_count ].to_i
            army.save!
          end
        end
      end
    end
    head :ok
  end

  private

end

