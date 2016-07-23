root = exports ? this

set_cities_reactivity = ->
  $('.can_recruit').click ->
    param = $( this ).attr( 'extra_params' )
    param = JSON.parse( param )

    city_id = param[ 'city_id' ]

    $( ".hidden_token" ).hide()
    $( ".phantom_army_for_city_#{city_id}" ).show()

phantom_reactivity_event = (var_this) ->

  console.log( var_this )
  root.foo = 0 unless root.foo
  root.foo += 1

  position = $( var_this ).offset();
  div_id = "counter_#{$( var_this ).attr( 'id' )}"

  if ($('#'+div_id).length)
    $('#'+div_id).html( root.foo )
  else
    div = "<div id=#{div_id} class='army_count recruit_army' style='top: #{position.top-25}px; left: #{position.left-1}px;'>#{root.foo}</div>"
    elem = $(div)
    elem.click ->
      phantom_reactivity_event( $(this) )
    $( '#map' ).append( elem )

set_phantom_token_reactivity = ->
  $('.recruit_army').click ->
    phantom_reactivity_event( $(this) )

$(document).on('turbolinks:load', set_cities_reactivity )
$(document).on('turbolinks:load', set_phantom_token_reactivity )