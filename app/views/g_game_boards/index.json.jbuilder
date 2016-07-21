json.array!(@g_game_boards) do |g_game_board|
  json.extract! g_game_board, :id
  json.url g_game_board_url(g_game_board, format: :json)
end
