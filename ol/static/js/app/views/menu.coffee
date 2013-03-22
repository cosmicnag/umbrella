define ['marionette','tpl!app/views/menu.tpl', 'cs!app/helpers/book'],(Marionette,template,BookHelper) ->
    class MenuView extends Marionette.ItemView
        template:template
        ui:
            querystring: '#querystring'
        events:
            'submit #searchForm': 'submitSearch'

        submitSearch: () ->
            BookHelper.fireQuery() #TODO: pass args

    MenuView
