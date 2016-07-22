require 'test_helper'

module Alliances

  class AlAllianceMasterTest < ActiveSupport::TestCase

    def setup
      GGameBoard.destroy_all

      @gb = GGameBoard.create!

      @stark, @karstark = HHouse.create_house_and_vassals( :stark, :karstark )
      @lannister, @cendermark = HHouse.create_house_and_vassals( :lannister, :cendermark )
      @greyjoy, @pyk = HHouse.create_house_and_vassals( :greyjoy, :pyk )
      @tyrell, @tarly = HHouse.create_house_and_vassals( :tyrell, :tarly )

      @gb.declare_major_houses( @stark, @lannister )
    end

    def test_alliance_master
      @gb.create_alliance( @stark, @greyjoy, 5 )
      @gb.create_alliance( @lannister, @tyrell, 5 )

      assert_equal @stark, @gb.alliance_master( @greyjoy )
      assert_equal @lannister, @gb.alliance_master( @tyrell )
    end

  end

end
