define ['marionette','jquery','cs!app/ol','tpl!app/views/bookgrid.tpl','tpl!app/views/booklist.tpl','tpl!app/views/bookdetail.tpl','cs!app/core/mediator'],(Marionette,$,OL,gridtemplate,listtemplate,detailtemplate,mediator) ->

    class BookBaseView extends Marionette.ItemView
        events:
            'click .contactLender': 'borrow'
        borrow: ->
            mediator.commands.execute 'modal','borrow',@model

    class BookGridView extends BookBaseView
        template: gridtemplate
        className: 'col25'

                
    class BookListView extends BookBaseView
        template: listtemplate

    class BookDetailView extends BookBaseView
        template: detailtemplate


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
