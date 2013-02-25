#Not needed
define ['marionette','tpl!app/views/bookgrid.tpl','tpl!app/views/booklist.tpl','tpl!app/views/bookdetail.tpl'],(Marionette,gridtemplate,listtemplate,detailtemplate) ->

    class BookView extends Marionette.ItemView
        template: ()
