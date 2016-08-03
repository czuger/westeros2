require 'test_helper'

class GArmiesHiringControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_game_board = create( :g_game_board )
  end

  test "should create an army recruitment entry" do
    assert_difference 'Armies::ToRecruit.count' do
      post g_game_board_g_armies_hiring_index_url( g_game_board_id: @g_game_board.id, armies_to_hire: { 0 => { q: 1, r: 1 } } )
    end
  end

end
