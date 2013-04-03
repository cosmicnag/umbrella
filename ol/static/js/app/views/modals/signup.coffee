define ['marionette', 'tpl!app/views/modals/signup.tpl'], (Marionette, template) ->
    class SignupModalView extends Marionette.ItemView
        template: template
        ui:
            username: '#username'
            password: '#password'
            password2: '#password2'
            email: '#email'
        events:
            'submit #formSignUp' : 'signup'
        signup: (e) ->
            e.preventDefault()
            username = @ui.username.val()
            password = @ui.password.val()
            password2 = @ui.password2.val()
            email = @ui.email.val()
            require ['cs!app/helpers/user'],(userhelper) =>
                userhelper.signUp username,password,password2,email
