module Alliances
  class BetsController < ApplicationController

    before_action :set_g_game_board_from_game_board_id, only: [:new, :create]

    def new
      @asking_house = HHouse.first
      @bets = {}

      @g_houses = @g_game_board.g_houses.joins( :h_house ).merge( HHouse.suzerains )

      # First we load the last bets for houses
      # @al_houses.each do |asking_al_house|
      #   @al_houses.each do |target_al_house|
      #     next if asking_al_house.h_house_id == target_al_house.h_house_id
      #     @bets[ asking_al_house.h_house_id ] = {} unless @bets[ asking_al_house.h_house_id ]
      #     @bets[ asking_al_house.h_house_id ][ target_al_house.h_house_id ] = @gb.min_bet_value( target_al_house.last_bet )
      #   end
      # end

      # Then we overload with current bets (if there are some)
      @g_game_board.al_bets.each do |b|
        @bets[ b.h_house_id ] = {} unless @bets[ b.h_house_id ]
        @bets[ b.h_house_id ][ b.h_target_house_id ] = b.bet
      end
    end

    def create
      allow_parameters( params )

      asking_house = HHouse.find( params[ :asking_house_id ] )

      houses_bets = params[ :houses_bets ].reject{ |_, v| v.empty? }

      ActiveRecord::Base.transaction do
        houses_bets.each do |k, v|
          @g_game_board.set_bet( asking_house, HHouse.find( k ), v ) unless asking_house.id == k.to_i
        end
      end
      redirect_to new_g_game_board_bet_path
    end

    private

    def allow_parameters params
      params.permit( :houses_bets )
    end

  end
end
