define ['marionette', 'tpl!app/views/modals/borrow.tpl'], (Marionette, template) ->
    class BorrowModalView extends Marionette.ItemView
        template: template
        ui:
            message: '#message'
        events:
            'submit #formBorrow' : 'borrow'
        borrow: (e) ->
            e.preventDefault()
            message = @ui.message.val()
            require ['cs!app/helpers/book'],(bookhelper) =>
                bookhelper.borrow @model.attributes._id,message
