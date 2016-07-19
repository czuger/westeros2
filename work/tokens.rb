require 'rmagick'

token_size = 22

canvas = Magick::Image.new( token_size+1, token_size+1 ) do |c|
  c.background_color= "Transparent"
end

gc = Magick::Draw.new

gc.circle( token_size/2, token_size/2, 0/2, token_size/2)

gc.draw(canvas)
canvas.write( 'token.png' )