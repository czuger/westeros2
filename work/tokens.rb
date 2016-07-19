require 'rmagick'
require 'fileutils'

SQUARE_BORDER=2
TOKEN_PATH = '../app/assets/images/tokens'
token_size = 22

houses_colors = {}
houses_colors[:stark] = 'white'
houses_colors[:lannister] = 'red'
houses_colors[:tully] = 'blue'
houses_colors[:pyk] = 'black'
houses_colors[:arryn] = 'cyan'
houses_colors[:tyrell] = 'green'
houses_colors[:baratheon] = 'yellow'
houses_colors[:martell] = 'orange'

def init_token( token_size, houses_colors, house )
  canvas = Magick::Image.new( token_size+1, token_size+1 ) do |c|
    c.background_color= "Transparent"
  end
  gc = Magick::Draw.new
  gc.fill( houses_colors[ house.to_sym ] )
  [ canvas, gc ]
end

def finalize_token( canvas, gc, file_prefix, house )
  gc.draw(canvas)

  house_code = house[0..1]
  FileUtils.mkdir_p(TOKEN_PATH)
  canvas.write( "#{TOKEN_PATH}/#{file_prefix}_#{house_code}.png" )
end

def draw_round_token( token_size, arc_beg, arc_end, house, file_prefix, houses_colors )
  canvas, gc = init_token( token_size, houses_colors, house )
  gc.arc( 0, 0, token_size, token_size, arc_beg, arc_end )
  finalize_token( canvas, gc, file_prefix, house )
end

def draw_up_square_token( token_size, house, file_prefix, houses_colors )
  canvas, gc = init_token( token_size, houses_colors, house )
  gc.polygon( SQUARE_BORDER, token_size-SQUARE_BORDER, SQUARE_BORDER, SQUARE_BORDER,
              token_size-SQUARE_BORDER, SQUARE_BORDER, SQUARE_BORDER, token_size-SQUARE_BORDER )
  finalize_token( canvas, gc, file_prefix, house )
end

def draw_down_square_token( token_size, house, file_prefix, houses_colors )
  canvas, gc = init_token( token_size, houses_colors, house )
  gc.polygon( token_size-SQUARE_BORDER, SQUARE_BORDER, token_size-SQUARE_BORDER, token_size-SQUARE_BORDER,
              SQUARE_BORDER, token_size-SQUARE_BORDER, token_size-SQUARE_BORDER, SQUARE_BORDER )
  finalize_token( canvas, gc, file_prefix, house )
end

%w( stark lannister tully pyk arryn tyrell baratheon martell ).each do |house|
  draw_round_token( token_size, 270+45, 90+45, house, 'ad', houses_colors )
  draw_round_token( token_size, 90+45 , 270+45, house, 'au', houses_colors )
  draw_up_square_token( token_size, house, 'cu', houses_colors )
  draw_down_square_token( token_size, house, 'cd', houses_colors )
end


# gc.circle( token_size/2, token_size/2, 0/2, token_size/2)

