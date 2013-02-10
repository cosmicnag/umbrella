define ['Backbone','cs!app/models/book'],(Backbone,Book) ->
  class Books extends Backbone.Collection
    model: Book
    url: '/api/books'
