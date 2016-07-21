module Misc
  module GameBoardHouse

    # Check if a house is a major house
    # Only major houses can initate an alliance or declare a war.
    def major_house?( house )
      g_house = GHouse.find_by( h_house_id: house.id )
      # If we do not find the house in al_house, then by default, the house is a minor alliance member.
      g_house&.major_house
    end

    # A minor house can not negotiate alliances and declare wars
    def declare_minor_houses( *houses )
      set_houses_status( houses, false )
    end

    # A major house can negotiate alliances and declare wars
    def declare_major_houses( *houses )
      set_houses_status( houses, true )
    end

    private

    def set_houses_status( houses_array, major )
      houses_array.each do |h|
        g_house = GHouse.where( g_game_board_id: id, h_house_id: h.id ).first_or_initialize
        g_house.major_house = major
        g_house.save!
      end
    end

  end
end
