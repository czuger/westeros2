require_relative '../../test_helper'

module Alliances
  class BetsControllerTest < ActionController::TestCase

    setup do
      @gb = FactoryGirl.create( :g_game_board )
      @stark = FactoryGirl.create( :stark )
      @lannister = FactoryGirl.create( :lannister )
      @gb.declare_major_houses( @stark )
      @gb.declare_minor_houses( @lannister )
    end

    # test "should get show" do
    #   get :show, g_game_board_id: @gb.id
    #   assert_response :success
    # end

    test "should get new" do
      get :new, params: { g_game_board_id: @gb.id }
      assert_response :success
    end

    test "should get create" do
      post :create, params: { g_game_board_id: @gb.id, asking_house_id: @stark.id, houses_bets: { @lannister.id => 14 } }
      assert_redirected_to new_g_game_board_bet_path

      get :new, params: { g_game_board_id: @gb.id }
      assert_response :success
    end

  end
end
