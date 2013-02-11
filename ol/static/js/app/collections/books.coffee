define ['Backbone','cs!app/models/book','backbone_paginator'],(Backbone,Book) ->
  class Books extends Backbone.Paginator.requestPager
    model: Book
    paginator_core:
      type: 'GET'
      url: '/api/books?'
    paginator_ui:
      firstPage:0
      currentPage:0
      perPage : 4
      totalPages: 5
    server_api:
      'sort' : '-_id'
    parse: (res) ->
      console.log res
      res.items
