require 'rhex'

COLORS={
  sea: 'DarkCyan  ', stepp: 'Khaki' , grass: 'LimeGreen', hills: 'Chocolate' , forest: 'DarkGreen', mountains: 'SaddleBrown', top_mountains: 'Gray ', swamps: 'DarkSeaGreen'
}

g = Hex::Grid.new( element_to_color_hash: COLORS )

map1 = nil
map2 = {}
File.open( 'map1.marshal', 'r' ){ |f| map1 = Marshal.load( f.read ) }

max_row = 35

map1.each do |k, v|
  r = k[1]
  new_row = max_row - r
  q = k[0] - ( ( new_row ) / 1 ) + ( max_row / 2 ) + 0.5
  # q = k[0]
  g.cset( q, new_row, val: v )
end

g.to_pic( 'map2.jpg' )

File.open( 'hex_grid.marshal', 'w' ){ |f| f.write( Marshal.dump( g ) ) }