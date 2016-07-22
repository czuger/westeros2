module Tokens
  module RefreshCities

    DECAL_TOP=-11
    DECAL_LEFT=4

    private

    def refresh_cities
      GGameBoardToken.where( g_game_board_id: id ).delete_all

      grid = Hex::Grid.new

      CCity.includes(:h_house).all.each do |city|

        h = Hex::Axial.new( city.q, city.r )
        coords = grid.to_xy( h )

        house_name = city.h_house.suzerain_or_self.code_name
        # puts house_name
        master_house = alliance_master( city.h_house )
        # puts master_house.inspect
        master_alliance_name = master_house ? master_house.code_name : house_name
        # puts master_alliance_name.inspect
        # puts

        t_up_fn = 'cu_' + house_name[ 0..1 ] + '.png'
        t_down_fn = 'cd_' + master_alliance_name[ 0..1 ] + '.png'

        g_game_board_tokens_cities.create!(
          q: city.q, r: city.r, left: coords[0]+DECAL_LEFT, top: coords[1]+DECAL_TOP,
          up_filename: t_up_fn, down_filename: t_down_fn )
      end
    end
  end
end