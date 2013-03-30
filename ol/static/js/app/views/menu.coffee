define ['marionette','tpl!app/views/menu.tpl', 'cs!app/helpers/book', 'cs!app/core/mediator'],(Marionette,template,BookHelper, mediator) ->
    class MenuView extends Marionette.ItemView
        template:template
        initialize:(options) ->
            super(options)
            @listenTo mediator.events, "search:queried", (queryObj) =>
                @ui.querystring.val(queryObj.query)
        ui:
            querystring: '#querystring'
        events:
            'submit #searchForm': 'submitSearch'

        submitSearch: () ->
            BookHelper.fireQuery() #TODO: pass args

    MenuView
