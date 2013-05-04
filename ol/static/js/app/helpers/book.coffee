define ['cs!app/ol','cs!app/views/menu','cs!app/views/layouts/content','cs!app/views/filter','cs!app/views/books','cs!app/collections/books', 'jquery','cs!app/core/mediator','require'],(OL,MenuView,ContentLayout,FilterView,BooksView,Books,$,mediator,require)=>
#define ['require',(require) ->
    #MenuView = require 'cs!app/views/menu'
    #ContentLayout = require 'cs!app/views/layouts/content'
    #FilterView = require 'cs!app/views/filter'
    #BooksView = require 'cs!app/views/books'
    #Books = require 'cs!app/collections/books'

    class BookHelper
        layoutrendered: false
        renderHome:(defaults = true)->
            return if @layoutrendered
            console.log "rendering home"
            OL.menu.show new MenuView()
            contentlayout = new ContentLayout()
            OL.content.show contentlayout
            contentlayout.render()
            contentlayout.filter.show new FilterView()
            @layoutrendered = true
            @query '','all','all','all','-_id' if defaults
            @getFilterData()

        query:(query, genre, author, lender, sort)->
            @renderHome(false) if not @layoutrendered
            queryObj = {
                query: query
                genre: genre
                author: author
                lender: lender
                sort: sort
            }
            OL.collections.books = books = new Books [], queryObj
            
            #mediator.events.trigger "search:queried", queryObj
            books.fetch {
                success:(collection) =>
                        
                    OL.content.currentView.books.show new BooksView({collection:books})
                }
        getFilterData:()->
            $.getJSON "/api/filters", {}, (response) =>
                mediator.events.trigger "filters:loaded",response

        borrow: (id,message,lender_ids) ->
            issignedin = mediator.requests.request 'issignedin'
            if not issignedin
                alert 'Please sign in / sign up.'
                return
            require ['cs!app/utils/ajax'],(ajaxutil) =>
                lenders = lender_ids.join(",")
                tosend =
                    id: id
                    message: message
                    lenders: lenders
                success_closure = (data) ->
                    console.log data
                    mediator.commands.execute 'closemodal'
                error_closure = (data) ->
                    alert data.error
                ajaxutil.ajax 'borrow',tosend,'POST',success_closure, error_closure
    

    new BookHelper()
