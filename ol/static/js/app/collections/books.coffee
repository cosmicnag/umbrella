define ['Backbone','cs!app/models/book', 'cs!app/views/booksview', 'jquery', 'backbone_paginator'],(Backbone,Book,BooksView,$) ->
  class Books extends Backbone.Paginator.requestPager
    model: Book
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
      sort : '-_id',
      page: () ->
        @currentPage      
      q: () ->
        $('#q').val()
    parse: (res) ->
      @totalPages = res.pages
      @currentPage = res.page
      console.log res
      res.items
