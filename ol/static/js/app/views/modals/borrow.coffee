define ['marionette', 'jquery', 'tpl!app/views/modals/borrow.tpl'], (Marionette, $, template) ->
    class BorrowModalView extends Marionette.ItemView
        template: template
        ui:
            message: '#message'
        events:
            'submit #formBorrow' : 'borrow'
        borrow: (e) ->
            e.preventDefault()
            message = @ui.message.val()
            lender_ids = []
            @$el.find('.lenderCheckbox').each () ->
                lender_id = $(this).attr('data-id')
                lender_ids.push lender_id
            console.log "lender ids", lender_ids
            require ['cs!app/helpers/book'],(bookhelper) =>
                bookhelper.borrow @model.attributes._id,message,lender_ids
