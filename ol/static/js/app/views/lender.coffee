#Not needed
define ['marionette','underscore','tpl!app/views/lender.tpl'],(Marionette,_,template) ->

    class BookView extends Marionette.ItemView
        template: template
