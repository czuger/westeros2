require_relative '../../test_helper'

module Alliances
  class BetsControllerTest < ActionController::TestCase

    setup do
      @gb = FactoryGirl.create( :g_game_board )
      @house = FactoryGirl.create( :stark )
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
      post :create, params: { g_game_board_id: @gb.id, asking_house_id: @house.id, houses_bets: { @house.id => 15 } }
      assert_redirected_to new_g_game_board_bet_path
    end

  end
end
