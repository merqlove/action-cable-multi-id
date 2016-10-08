App.messages = App.cable.subscriptions.create "MessageChannel",
  collection: -> $("[data-channel='messages']")

  connected: ->
    # FIXME: While we wait for cable subscriptions to always be finalized before sending messages
    setTimeout =>
      @installPageChangeCallback()
    , 1000

  rejected: ->
    console.log ('Rejected MessageChannel')

  received: (data) ->
    @collection().append(data.message) unless @userIsCurrentUser(data.message)

  userIsCurrentUser: (message) ->
    $(message).attr('data-user-id') is $('meta[name=current-user]').attr('id')

  installPageChangeCallback: ->
    App.public_messages.unsubscribe()
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
