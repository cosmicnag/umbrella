define ['marionette', 'tpl!app/views/modals/credits.tpl'], (Marionette, template) ->
    class BorrowModalView extends Marionette.ItemView
        template: template
