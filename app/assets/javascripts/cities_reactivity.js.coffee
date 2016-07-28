set_cities_reactivity = ->
  $('.can_recruit').click ->
    param = $( this ).attr( 'extra_params' )
    param = JSON.parse( param )

    city_id = param[ 'city_id' ]

    $( ".no_armies_on_token" ).hide()
    $( ".phantom_army_for_city_#{city_id}" ).show()

$(document).on('turbolinks:load', set_cities_reactivity )