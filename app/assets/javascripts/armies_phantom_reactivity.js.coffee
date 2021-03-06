root = exports ? this

phantom_reactivity_event = (var_this) ->

  root.army_counter= {} unless root.army_counter

  position = $( var_this ).offset();
  # console.log( var_this )
  $( var_this ).removeClass( 'no_armies_on_token' )
  div_id = $( var_this ).attr( 'id' )
  div_id = 'counter_'+div_id unless div_id[0..7] == 'counter_'

  root.army_counter[ div_id ] = 0 unless root.army_counter[ div_id ]

  remove_armies_cb = $("#remove_armies_cb");

  if remove_armies_cb.is(':checked')
    root.army_counter[ div_id ] -= 1 if root.army_counter[ div_id ] > 0
  else
    root.army_counter[ div_id ] += 1 unless root.army_counter[ div_id ] >= 6

  if ($('#'+div_id).length)
    $('#'+div_id).html( root.army_counter[ div_id ] )
  else
    div = "<div id=#{div_id} class='army_count recruit_army'" +
     " q=#{var_this.attr( 'q' )} r=#{var_this.attr( 'r' )} extra_params=#{var_this.attr( 'extra_params' )}" +
     " style='top: #{position.top-31}px; left: #{position.left-1}px;'>" +
     "#{root.army_counter[ div_id ]}</div>"
    elem = $(div)
    elem.click ->
      phantom_reactivity_event( $(this) )
    $( '#map' ).append( elem )

set_phantom_token_reactivity = ->
  $('.recruit_army').click ->
    phantom_reactivity_event( $(this) )

$(document).on('turbolinks:load', set_phantom_token_reactivity )