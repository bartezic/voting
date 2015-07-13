window.Voting = window.Voting || {}
window.Voting.Faye =
  subscribeTo: (channel) ->
    console.log "Subscribed to #{channel}"
    @client.unsubscribe channel
    @client.subscribe channel, (data) ->
      eval(data)

  init: ->
    if (typeof Faye != 'undefined') && !@client
      @client = new Faye.Client("//#{window.fayeHost}/faye")
      @subscribeTo("/answers")

$(document).on "ready page:load", -> window.Voting.Faye.init()