App.public_messages = App.cable.subscriptions.create "PublicMessageChannel",
  collection: -> $("[data-channel='messages']")

  connected: ->
    # FIXME: While we wait for cable subscriptions to always be finalized before sending messages
    setTimeout =>
      @installPageChangeCallback()
    , 1000

  rejected: ->
    console.log ('Rejected PublicMessageChannel')

  received: (data) ->
    @collection().append(data.message)

  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
