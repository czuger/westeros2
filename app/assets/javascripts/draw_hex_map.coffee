draw_hex_flat_topped = ( canvasContext, x, y, radius, color ) ->
  width = radius*2.0
  height = Math.sqrt(3)/2.0 * width

  x = x+(width/2)
  y = y+(height/2)

  canvasContext.beginPath()
  canvasContext.moveTo(x + radius, y)
  canvasContext.lineTo(x + width/4, y + height/2)
  canvasContext.lineTo(x - width/4, y + height/2)
  canvasContext.lineTo(x - radius, y)
  canvasContext.lineTo(x - width/4, y - height/2)
  canvasContext.lineTo(x + width/4, y - height/2)
  canvasContext.moveTo(x + radius, y)
  canvasContext.closePath()
  canvasContext.fillStyle = color
  canvasContext.fill()


draw_hex_pointy_topped = ( canvasContext, x, y, radius, color ) ->
  height = radius*2.0
  width = Math.sqrt(3)/2.0 * height

  x = x+(width/2)
  y = y+(height/2)

  canvasContext.beginPath()
  canvasContext.moveTo(x, y - radius)
  canvasContext.lineTo(x + width/2, y - height/4)
  canvasContext.lineTo(x + width/2, y + height/4)
  canvasContext.lineTo(x, y + radius)
  canvasContext.lineTo(x - width/2, y + height/4)
  canvasContext.lineTo(x - width/2, y - height/4)
  canvasContext.moveTo(x, y - radius)
  canvasContext.closePath()
  canvasContext.fillStyle = color
  canvasContext.fill()


draw_hex = ( q, r, color, canvasContext, radius) ->
  xy = qr_to_xy( q, r )
  draw_hex_pointy_topped( canvasContext, xy[0], xy[1], radius, color )


draw_full_map = () ->
  map_data = $( '#color_map' ).val()
  map_data = eval('(' + map_data + ')')

  canvas=document.getElementById("map");
  context = canvas.getContext("2d")

  hex_ray = get_hex_ray();

  for hex in map_data
    draw_hex( hex[ 0 ], hex[ 1 ], hex[ 2 ], context, hex_ray )

  $( '#board' ).append( canvas )

$(document).ready ->
  draw_full_map()