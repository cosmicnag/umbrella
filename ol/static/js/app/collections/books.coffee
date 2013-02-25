define ['backbone','cs!app/models/book', 'cs!app/views/booksview', 'jquery', 'backbone_paginator'],(Backbone,Book,BooksView,$) ->
  class Books extends Backbone.Paginator.requestPager
    model: Book
    initialize: (models, options) ->
        super()
        @server_api.q = (if options.query != '' then options.query else null)
        @server_api.author = (if options.author != 'all' then options.author else null)
        @server_api.genre = (if options.genre != 'all' then options.genre else null)
        @server_api.lender = (if options.lender != 'all' then options.lender else null)
        @server_api.sort = options.sort
        
    paginator_core:
      type: 'GET'
      dataType: 'json'
      url: '/api/books?'
    paginator_ui:
      firstPage:1
      currentPage:1
      perPage : 8
      totalPages: 5
    server_api:
      page: () ->
        @currentPage
    parse: (res) ->
      @totalPages = res.pages
      @currentPage = res.page
      res.items
