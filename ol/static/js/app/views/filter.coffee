define ['marionette','tpl!app/views/filter.tpl','cs!app/core/mediator','jquery','underscore','require'],(Marionette,template,mediator,$,_,require) ->
    class FilterCollection extends Backbone.Collection #For authors,genres,lenders.
    class FilterView extends Marionette.ItemView
        template: template
        initialize:(options) ->
            super()
            [$authors,$lenders,$genres] =[[],[],[]]
            @listenTo mediator.events,"filters:loaded",(filterdata) =>
                $authors.push($("<option>").attr('value',obj[0]).text(obj[1]))  for obj in _.pairs(filterdata.authors)
                $lenders.push($("<option>").attr('value',obj[0]).text(obj[1]))  for obj in _.pairs(filterdata.lenders)
                $genres.push($("<option>").attr('value',obj).text(obj)) for obj in filterdata.genres
                @ui.author.append $authors
                @ui.lender.append $lenders
                @ui.genre.append $genres
        ui:
            author: '#author'
            genre: '#genre'
            lender: '#lender'
            search: '#search'
            sort: '#sort'
            #TODO grid/list
        events:
            'click #search': 'fireQuery'
            'click #detailview' : 'showdetailview'
            'click #listview' :'showlistview'
            'click #gridview' : 'showgridview'
        fireQuery: ()->
            [author,genre,lender,sort] = [window.encodeURIComponent(@ui.author.val()),@ui.genre.val(),@ui.lender.val(),@ui.sort.val()]
            querystring = mediator.requests.request "querystring"
            mediator.commands.execute "firequery",querystring,genre,author,lender,sort
        showdetailview:() ->
            mediator.events.trigger "filters:view",'detail'
        showlistview:() ->
            mediator.events.trigger "filters:view",'list'
        showgridview:() ->
            mediator.events.trigger "filters:view",'grid'
    FilterView
