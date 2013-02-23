define ['backbone','cs!app/models/book','cs!app/collections/books','jquery','text!app/views/bookview.tpl'],(Backbone,Book,Books,$,template) ->
  class BookView extends Backbone.View
    tagName: 'div'
    className: 'col25'
    initialize : ->
      _.bindAll @,'render'
      @template = _.template(template)
    render: ->
      console.log @template
      $(@el).append($(@template(@model.toJSON)))
      @
      
    
