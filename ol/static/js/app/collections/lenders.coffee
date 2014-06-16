define ['backbone','cs!app/models/lender'],(Backbone,Lender) ->
  class Lenders extends Backbone.Collection
    model: Lender
