define ['cs!app/ol','cs!app/views/menu','cs!app/views/layouts/content','cs!app/views/filter','cs!app/views/books','cs!app/collections/books'],(OL,MenuView,ContentLayout,FilterView,BooksView,Books)=>
#define ['require',(require) ->
    #MenuView = require 'cs!app/views/menu'
    #ContentLayout = require 'cs!app/views/layouts/content'
    #FilterView = require 'cs!app/views/filter'
    #BooksView = require 'cs!app/views/books'
    #Books = require 'cs!app/collections/books'

    class BookHelper

        renderHome:()->
            OL.menu.show new MenuView()
            contentlayout = new ContentLayout()
            OL.content.show contentlayout
            contentlayout.render()
            contentlayout.filter.show new FilterView()
            initialbooks = new Books({querystring:'',sort:'-id'})
            initialbooks.fetch {
                success:(collection,response,options) =>
                    contentlayout.books.show new BooksView({collection:collection})
                }
    new BookHelper()
