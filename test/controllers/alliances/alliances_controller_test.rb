require 'test_helper'

module Alliances
  class AlliancesControllerTest < ActionController::TestCase

    setup do
      @g_game_board = create( :g_game_board )

      @stark = FactoryGirl.create( :stark )
      @lannister = FactoryGirl.create( :lannister )
      @greyjoy = FactoryGirl.create( :greyjoy )

      @g_game_board.declare_major_houses( @stark )
      @g_game_board.create_alliance( @stark, @greyjoy, 10 )
      @g_game_board.set_enemies( @stark, @lannister )

    end

    test "should get show" do
      get :show, params: { g_game_board_id: @g_game_board.id }
      assert_response :success
    end

    test "should get log" do
      create( :al_log, g_game_board_id: @g_game_board.id )
      get :log, params: { g_game_board_id: @g_game_board.id }
      assert_response :success
    end

  end
end
