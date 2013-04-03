define ['marionette', 'tpl!app/views/modals/signin.tpl'], (Marionette, template) ->
    class SignupModalView extends Marionette.ItemView
        template: template
        ui:
            username: '#username'
            password: '#password'
        events:
            'submit #formSignIn' : 'signin'
        signin: (e) ->
            e.preventDefault()
            username = @ui.username.val()
            password = @ui.password.val()
            require ['cs!app/helpers/user'],(userhelper) =>
                userhelper.signIn username,password
