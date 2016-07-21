require 'test_helper'

class GGameBoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @g_game_board = create( :g_game_board )
    @stark = create( :stark )
    @lannister = create( :lannister )
    @city = create( :c_city, h_house_id: @stark.id )
  end

  test "should get next_turn" do
    get g_game_board_next_turn_url( @g_game_board )
    assert_redirected_to g_game_board_url(@g_game_board)
  end

  test "should get show" do
    @g_game_board.refresh_tokens
    get g_game_board_url( @g_game_board )
    assert_response :success
  end

  test "should get index" do
    get g_game_boards_url
    assert_response :success
  end

  test "should get new" do
    get new_g_game_board_url
    assert_response :success
  end

  test "should create g_game_board" do
    assert_difference('GGameBoard.count') do
      post g_game_boards_url, params: { g_game_board: {  } }
    end

    assert_redirected_to g_game_board_url(GGameBoard.last)
  end

  test "should show g_game_board" do
    get g_game_board_url(@g_game_board)
    assert_response :success
  end

  test "should get edit" do
    get edit_g_game_board_url(@g_game_board)
    assert_response :success
  end

  test "should update g_game_board" do
    patch g_game_board_url(@g_game_board), params: { g_game_board: {  } }
    assert_redirected_to g_game_board_url(@g_game_board)
  end

  test "should destroy g_game_board" do
    assert_difference('GGameBoard.count', -1) do
      delete g_game_board_url(@g_game_board)
    end

    assert_redirected_to g_game_boards_url
  end
end
