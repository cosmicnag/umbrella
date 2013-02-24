define ['backbone','cs!app/models/book', 'cs!app/views/booksview', 'jquery', 'backbone_paginator'],(Backbone,Book,BooksView,$) ->
  class Books extends Backbone.Paginator.requestPager
    model: Book
    initialize: (options) ->
        super()
        @server_api.q = options.querystring
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
      console.log res
      res.items
