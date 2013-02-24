define ['marionette','cs!app/core/router','backbone'],(Marionette,OLRouter,Backbone) ->
    OL = new Marionette.Application()
    OL.addRegions
        menu: '#menuBlock'
        content: '#contentBlock'
    OL.addInitializer ()->
        console.log "init"
        @router = new OLRouter()
        Backbone.history.start()
    OL
