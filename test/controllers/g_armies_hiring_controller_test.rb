require 'test_helper'

class GArmiesHiringControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_game_board = create( :g_game_board )
    @house = create( :lannister )
  end

  test "should create an army recruitment entry then update it" do
    assert_difference 'Armies::ToRecruit.count' do
      post g_game_board_g_armies_hiring_index_url( g_game_board_id: @g_game_board.id,
        armies_to_hire: { 0 => { q: 1, r: 1, house_id: @house.id, army_count: 2 } } )
    end

    assert_no_difference 'Armies::ToRecruit.count' do
      post g_game_board_g_armies_hiring_index_url( g_game_board_id: @g_game_board.id,
        armies_to_hire: { 0 => { q: 1, r: 1, house_id: @house.id, army_count: 3 } } )
    end
  end

end
