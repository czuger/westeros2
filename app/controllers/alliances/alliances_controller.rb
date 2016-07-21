module Alliances
  class AlliancesController < ApplicationController

    before_action :set_g_game_board_from_game_board_id, only: [:show, :log]

    def log
      @logs = @g_game_board.westeros_alliances_al_logs.order( 'updated_at DESC' )
    end

    def show
      @suzerains = HHouse.suzerains.order( :id )

      @suzerains_names = @suzerains.map(&:code_name)
      @suzerains_ids = @suzerains.map(&:id)

      @alliances_hash = {}

      @suzerains.each do |suzerain_a|
        @alliances_hash[ suzerain_a.id ] = []
        @suzerains.each do |suzerain_b|
          @alliances_hash[ suzerain_a.id ] << alliance_status_code( suzerain_a, suzerain_b )
        end
      end
    end

    private

    def alliance_status_code( suzerain_a, suzerain_b )
      if suzerain_a == suzerain_b
        return :same
      elsif @g_game_board.allied?( suzerain_a, suzerain_b )
        return :allied
      elsif @g_game_board.enemies?( suzerain_a, suzerain_b )
        return :enemies
      end
      :neutral
    end

  end
end
