define ['marionette','tpl!app/views/bookgrid.tpl','tpl!app/views/booklist.tpl','tpl!app/views/bookdetail.tpl','cs!app/core/mediator'],(Marionette,gridtemplate,listtemplate,detailtemplate,mediator) ->

    class BookGridView extends Marionette.ItemView
        template: gridtemplate
        className: 'col25'
        templateHelpers:
            get_image_url:()->
              if @covers? then "http://covers.openlibrary.org/b/id/#{@covers[0]}-L.jpg" else "http://placehold.it/180x253&text=#{@title}"
                
    class BookListView extends Marionette.ItemView
        template: listtemplate
        templateHelpers:
            get_image_url:()->
              if @covers? then "http://covers.openlibrary.org/b/id/#{@covers[0]}-L.jpg" else "http://placehold.it/180x253&text=#{@title}"
    class BookDetailView extends Marionette.ItemView
        template: detailtemplate
        templateHelpers:
            get_image_url:()->
              if @covers? then "http://covers.openlibrary.org/b/id/#{@covers[0]}-L.jpg" else "http://placehold.it/180x253&text=#{@title}"

    class BooksView extends Marionette.CollectionView
        id: () ->
            @attributes = {view:'grid'} if typeof @attributes is "undefined"
            switch @attributes['view']
                when "grid" then "browseGridView"
                when "list" then "browseListView"
                when "detail" then "browseDetailsView"
        initialize: () ->
            @listenTo mediator.events,"filters:view",(viewtype) =>
                @attributes.view = viewtype
                @render()
            
        itemView: @getItemView
        getItemView: (item)->
            @attributes = {view:'grid'} if typeof @attributes is "undefined"
            switch @attributes['view']
                when "grid" then BookGridView
                when "list" then BookListView
                when "detail" then BookDetailView
                
    BooksView
