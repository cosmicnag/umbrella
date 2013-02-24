define ['marionette','cs!app/core/controller'],(Marionette,OLController) ->
    class OLRouter extends Marionette.AppRouter
        controller: OLController
        appRoutes:
            "" : "home"
            "query/:query/genre/:genre/author/:author/lender/:lender/sort/:sort": "query"
                
