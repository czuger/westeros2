set_army_validation_button = ->
  $('#save_army_recruitment').click ->

    armies_count = $( '.army_count' )

    armies_array = []

    for army, i in armies_count
      
      # The count of the banners in the army
      army_count = $( army ).html()
      extra_params = JSON.parse( $( army ).attr( 'extra_params' ) )
      
      # The id of the recruiting house (HHouse)
      h_id = extra_params[ 'h_id' ]
      
      # q and r
      q = $( army ).attr( 'q' )
      r = $( army ).attr( 'r' )

      armies_array.push { army_count: army_count, q: q, r: r, house_id: h_id }

    console.log( armies_array )

    game_board_id = $( '#g_game_board_id' ).val()
      
      # TODO : need to post that to the server to keep the position of the recruiting armies.

    $.post "/g_game_boards/#{game_board_id}/g_armies_hiring",
      armies_to_hire: armies_array
      (data) -> $('body').append "Successfully posted to the page."
    
$(document).on('turbolinks:load', set_army_validation_button )