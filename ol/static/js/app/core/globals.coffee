define ['backbone'],(Backbone) ->
    class Globals extends Backbone.Model
        defaults:
            'issignedin' : false
    new Globals()
