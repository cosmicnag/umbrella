define ['backbone'],(Backbone) ->
  class Book extends Backbone.Model

    idAttribute: "_id"

    defaults:
      subtitle: ''

    initialize: () ->
      super()
      if @attributes.covers
        @attributes.image_url = "http://covers.openlibrary.org/b/id/#{@attributes.covers[0]}-L.jpg"
      else
        @attributes.image_url =  "http://placehold.it/180x253&text=#{@getEncodedTitle()}"

    getEncodedTitle: () ->
      @attributes.title.replace(/\s/g,"+")

        
