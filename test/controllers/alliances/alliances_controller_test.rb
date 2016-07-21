require 'test_helper'

module Alliances
  class AlliancesControllerTest < ActionController::TestCase

    setup do
      @g_game_board = create( :g_game_board )
      @stark = FactoryGirl.create( :stark )
      @lannister = FactoryGirl.create( :lannister )
    end

    test "should get show" do
      get :show, params: { g_game_board_id: @g_game_board.id }
      assert_response :success
    end

    test "should get log" do
      get :log, params: { g_game_board_id: @g_game_board.id }
      assert_response :success
    end

  end
end
