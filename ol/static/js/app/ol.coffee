define ['marionette','cs!app/core/router','backbone'],(Marionette,OLRouter,Backbone) ->
    OL = new Marionette.Application
        collections: {}
        
    
    OL.addRegions
        menu: '#menuBlock'
        content: '#contentBlock',
        modal: '.lightBoxContent'
    OL.addInitializer ()->
        console.log "init"
        @router = new OLRouter()
        Backbone.history.start()
    window.OL = OL
    OL
