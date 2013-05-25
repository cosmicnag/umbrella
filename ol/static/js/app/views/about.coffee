#Not needed
define ['marionette','tpl!app/views/about.tpl'],(Marionette,template) ->

    class BookView extends Marionette.ItemView
        className: 'about'
        template: template
