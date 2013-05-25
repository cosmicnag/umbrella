define ['marionette','cs!app/core/controller'],(Marionette,OLController) ->
    class OLRouter extends Marionette.AppRouter
        controller: OLController
        appRoutes:
            "" : "home"
            "about": "about"
            "lenders": "lenders"
            "lender/:id": "lenders"
            "borrow/:id": "borrow"
            "genre/:genre/author/:author/lender/:lender/sort/:sort/query/:query": "query"
            "genre/:genre/author/:author/lender/:lender/sort/:sort": "query"
                
