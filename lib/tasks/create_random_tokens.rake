
desc 'Fill map with tokens'
task :fill_map_with_tokens => :environment do

  grid = Hex::Grid.new
  g = GGameBoard.first
  @tokens = []

  houses = %w( stark lannister tully pyk arryn tyrell baratheon martell )
  alliances = houses[ 0 .. 1 ]
  ca = %w( c a )

  GGameBoardToken.delete_all

  ( 0 .. 45 ).each do |q|
    ( 0 .. 30 ).each do |r|
      next if g.g_game_board_tokens.where( q: q, r: r ).first

      house = houses.sample
      alliance = alliances.sample
      t = ca.sample
      h = Hex::Axial.new( q, r )
      coords = grid.to_xy( h )

      t_up_fn = t + 'u_' + house[ 0..1 ] + '.png'
      t_down_fn = t + 'd_' + alliance[ 0..1 ] + '.png'

      g.g_game_board_tokens.create!( q: q, r: r, left: coords[0]+11, top: coords[1]-3,
                                     up_filename: t_up_fn, down_filename: t_down_fn )
    end
  end
end

desc 'Create random tokens'
task :create_random_tokens => :environment do

  grid = Hex::Grid.new
  g = GGameBoard.first
  @tokens = []

  houses = %w( stark lannister tully pyk arryn tyrell baratheon martell )
  alliances = houses[ 0 .. 1 ]
  ca = %w( c a )

  GGameBoardToken.delete_all

  ( 0 .. 30 ).each do
    q = ( 0 .. 45 ).to_a.sample
    r = ( 0 .. 30 ).to_a.sample

    next if g.g_game_board_tokens.where( q: q, r: r ).first

    house = houses.sample
    alliance = alliances.sample
    t = ca.sample
    h = Hex::Axial.new( q, r )
    coords = grid.to_xy( h )

    t_up_fn = t + 'u_' + house[ 0..1 ] + '.png'
    t_down_fn = t + 'd_' + alliance[ 0..1 ] + '.png'

    g.g_game_board_tokens.create!( q: q, r: r, left: coords[0]+11, top: coords[1]-3,
                                   up_filename: t_up_fn, down_filename: t_down_fn )

  end
end
