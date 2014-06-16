define ['marionette','tpl!app/views/filter.tpl','cs!app/core/mediator','typeahead','underscore','require'],(Marionette,template,mediator,$,_,require) ->
    engine =
      compile: (template) ->
          compiled = _.template(template)
          render: (context) ->
             compiled context

    class FilterCollection extends Backbone.Collection #For authors,genres,lenders.
    class FilterView extends Marionette.ItemView
        template: template
        initialize:(options) ->
            super()
            [$authors,$lenders,$genres] =[[],[],[]]

            @listenTo mediator.events,"filters:loaded",(filterdata) =>

                #$authors.push($("<option>").attr('value',obj[0]).text(obj[1]))  for obj in _.pairs(filterdata.authors)
                console.log "filterdata", filterdata
                console.log "authors", _.pairs(filterdata.authors)
                $('#author').typeahead
                    name: 'author'
                    remote: '/api/authors/%QUERY.json'
                    engine: engine
                    valueKey: 'name'
                    template: "<p><%= name %></p>"
                $('#author').on 'typeahead:selected', (e, datum) =>
                    console.log datum
                    querystring = mediator.requests.request "querystring"
                    mediator.commands.execute "firequery", querystring, @ui.genre.val(), datum.value, @ui.lender.val(), @ui.sort.val()

                $('#genre').typeahead
                    name: 'genre'
                    remote: '/api/genres/%QUERY.json'
                    engine: engine
                    template: "<p><%= value %></p>"

                $('#genre').on 'typeahead:selected', (e, datum) =>
                    console.log datum
                    querystring = mediator.requests.request "querystring"
                    mediator.commands.execute "firequery", querystring, datum.value, @ui.author.val(), @ui.lender.val(), @ui.sort.val()

                $('#querystring').on "keyup", (e) =>
                    console.log "querystring keyup"
                    if (e.keyCode == 13)
                        qstring = @ui.querystring.val()
                        mediator.commands.execute "firequery", qstring, @ui.genre.val(), @ui.author.val(), @ui.lender.val(), @ui.sort.val()

                $lenders.push($("<option>").attr('value',obj[0]).text(obj[1]))  for obj in _.pairs(filterdata.lenders)
                #$genres.push($("<option>").attr('value',obj).text(obj)) for obj in filterdata.genres
                #@ui.author.append $authors
                @ui.lender.append $lenders
                #@ui.genre.append $genres

            @listenTo mediator.events, "search:queried", (queryObj) =>
                console.log "search query event"
                #@ui.author.val(queryObj.author)
                #@ui.genre.val(queryObj.genre)
                #@ui.lender.val(queryObj.lender)
                
        ui:
            author: '#author'
            genre: '#genre'
            lender: '#lender'
            search: '#search'
            sort: '#sort'
            querystring: '#querystring'
            #TODO grid/list
        events:
            'click #search': 'fireQuery'
            'click #detailview' : 'showdetailview'
            'click #listview' :'showlistview'
            'click #gridview' : 'showgridview'
            'click #reset': 'resetQuery'
            'click #nextPage': 'nextPage'
            'click #prevPage': 'prevPage'
            'change #lender': 'fireQuery'
            'change #sort': 'fireQuery'
            #'change #author, #genre, #lender, #sort': 'fireQuery'
        fireQuery: ()->
            [@author,@genre,@lender,@sort] = [window.encodeURIComponent(@ui.author.val()),@ui.genre.val(),@ui.lender.val(),@ui.sort.val()]
            @querystring = @ui.querystring.val()
            #@querystring = mediator.requests.request "querystring"
            mediator.commands.execute "firequery",@querystring,@genre,@author,@lender,@sort
        showdetailview:() ->
            mediator.events.trigger "filters:view",'detail'
        showlistview:() ->
            mediator.events.trigger "filters:view",'list'
        showgridview:() ->
            mediator.events.trigger "filters:view",'grid'
        nextPage:(e) ->
            e.preventDefault()
            OL.collections.books.requestNextPage()
        prevPage:(e) ->
            e.preventDefault()
            OL.collections.books.requestPreviousPage()

        resetQuery: ()->
            @ui.author.val('')
            @ui.genre.val('')
            @ui.lender.val('')
            @ui.sort.val('')
            @ui.querystring.val('')
            @fireQuery()

    FilterView
