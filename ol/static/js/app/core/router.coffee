define ['marionette','cs!app/core/controller'],(Marionette,OLController) ->
    class OLRouter extends Marionette.AppRouter
        controller: OLController
        appRoutes:
            "" : "home"
                
