$(document).ready ->
  $('.can_recruit').click ->
    param = $( this ).attr( 'extra_params' )
    param = JSON.parse( param )
    console.log( param[ 'toto' ] )