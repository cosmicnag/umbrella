define ['marionette', 'tpl!app/views/modals/mail.tpl'], (Marionette, template) ->
    class BorrowModalView extends Marionette.ItemView
        template: template
