define ['Backbone'],(Backbone) ->
  class Book extends Backbone.Model
    idAttribute: "_id"
    getEncodedTitle: () ->
      @attributes.title.replace(/\s/g,"+")
    get_image_url:()->
      if @attributes.covers? then "http://covers.openlibrary.org/b/id/#{@attributes.covers[0]}-L.jpg" else "http://placehold.it/180x253&text=#{@getEncodedTitle()}"
        
