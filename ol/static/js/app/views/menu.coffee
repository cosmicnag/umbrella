define ['marionette','tpl!app/views/menu.tpl'],(Marionette,template) ->
    class MenuView extends Marionette.ItemView
        template:template
        ui:
            querystring: '#querystring'
    MenuView
