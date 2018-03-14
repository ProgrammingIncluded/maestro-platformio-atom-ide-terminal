DDPClient = require "ddp";

module.exports =
  class MaestroInterop
    constructor: ->
      @ddpclient = new DDPClient(
        host: "localhost",
        port: 3000,
        ssl: false,
        autoReconnect: true,
        autoReconenctTimer: 500,
        maintainCollections: true,
        dppVersion: "1",
        useSockJs: true,
        url: "ws://localhost:3000"
      )

      @ddpclient.connect @connect()

    reset: ->
      @ddpclient.call "terminal.reset",
        [],
        (err, result) -> return,
        () -> return

    transmit: (data)->
      # We want to convert carriage returns to new line.
      @ddpclient.call "terminal.transmit",
        [data],
        (err, result) -> return,
        () -> return

    connect: (error, wasReconnect)->
      return () ->
        if error
          console.log "DDP Connection Error!"
          return
        if wasReconnect
          console.log "Restablish"
          return
        console.log "Connected"
