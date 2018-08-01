$(document).ready ->
  $('#customer-link').click (event) ->
    event.preventDefault()
    $('#hidden-form').fadeToggle()
