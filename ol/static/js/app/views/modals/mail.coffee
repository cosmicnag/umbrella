define ['marionette', 'jquery', 'cs!app/core/mediator', 'tpl!app/views/modals/mail.tpl'], (Marionette, $, mediator, template) ->
    class BorrowModalView extends Marionette.ItemView
        template: template
        events:
            'submit #formMail': 'mail'
        ui:
            'message': '#mailmessage'
            'email': '#mailemail'
        mail: (e) ->
            e.preventDefault()
            url = '/mail_contact'
            data = {
                message: @ui.message.val()
                email: @ui.email.val()
            }
            $.post url, data, (response) ->
                #responseObj = JSON.parse response
                mediator.commands.execute "closemodal"
