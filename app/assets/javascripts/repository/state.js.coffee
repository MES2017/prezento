class Repository.State
  constructor: (@repository_id) ->

  poll_state: (last_state) ->
    $.post('/repositories/' + @repository_id + '/state',
           last_state: last_state)

  schedule_poll_state: (last_state) ->
    context = this
    call = () ->
      context.poll_state(last_state)

    setTimeout(call, 15000) # Delays in 15s the next call

  @set_loader: (loading_html) ->
    $('div#processing_information').html(loading_html)