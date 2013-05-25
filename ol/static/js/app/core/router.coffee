define ['marionette','cs!app/core/controller'],(Marionette,OLController) ->
    class OLRouter extends Marionette.AppRouter
        controller: OLController
        appRoutes:
            "" : "home"
            "lenders": "lenders"
            "borrow/:id": "borrow"
            "genre/:genre/author/:author/lender/:lender/sort/:sort/query/:query": "query"
            "genre/:genre/author/:author/lender/:lender/sort/:sort": "query"
                
