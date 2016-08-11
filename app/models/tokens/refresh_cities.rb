module Tokens
  module RefreshCities

    DECAL_TOP=-11
    DECAL_LEFT=4

    private

    def refresh_cities

      grid = Hex::Grid.new

      CCity.includes(:h_house).all.each do |city|

        h = Hex::Axial.new( city.q, city.r )
        coords = grid.to_xy( h )

        master_house = city.h_house.suzerain_or_self
        master_house_name = master_house.code_name

        alliance_master_house = alliance_master( city.h_house )
        alliance_master_house = alliance_master_house ? alliance_master_house : master_house
        alliance_master_house_name = alliance_master_house.code_name

        city_token_up_fn= 'cu_' + master_house_name[ 0..1 ] + '.png'
        city_token_down_fn = 'cd_' + alliance_master_house_name[ 0..1 ] + '.png'

        g_game_board_tokens_cities.create!(
          q: city.q, r: city.r, left: coords[0]+DECAL_LEFT, top: coords[1]+DECAL_TOP,
          up_filename: city_token_up_fn, down_filename: city_token_down_fn, show: true,
          extra_parameters:
            { city_id: city.id, mh_id: master_house.id, amh_id: alliance_master_house.id,
              h_id: city.h_house.id }
          )
      end
    end

    def refresh_phantom_armies

      grid = Hex::Grid.new

      g_game_board_tokens_cities.each do |token|

        master_house = HHouse.find( token.extra_parameters[ :mh_id ] )
        master_house_name = master_house.code_name

        alliance_master_house = HHouse.find( token.extra_parameters[ :amh_id ] )
        alliance_master_house_name = alliance_master_house.code_name

        city_h = Hex::Axial.new( token.q, token.r )

        phantom_army_token_up_fn= 'au_' + master_house_name[ 0..1 ] + '.png'
        phantom_army_token_down_fn = 'ad_' + alliance_master_house_name[ 0..1 ] + '.png'

        surrounding_hexes = city_h.get_surrounding_hexs

        surrounding_hexes.each do |shex|
          next if g_game_board_tokens_cities.where( q: shex.q, r: shex.r ).exists?
          # We will need to add existing armies here
          coords = grid.to_xy( shex )
          g_game_board_tokens_phantom_armies.create!(
            q: shex.q, r: shex.r, left: coords[0]+DECAL_LEFT, top: coords[1]+DECAL_TOP,
            up_filename: phantom_army_token_up_fn, down_filename: phantom_army_token_down_fn, show: false,
            extra_parameters: { city_id: token.extra_parameters[ :city_id ],
                                h_id: token.extra_parameters[ :h_id ]} )
        end
      end
    end

  end
end