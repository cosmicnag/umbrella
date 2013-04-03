define ['require','cs!app/core/mediator'],(require,mediator) ->
    class UserHelper
        signUp: (username,password,password2,email) ->
            require ['cs!app/utils/ajax'],(ajaxutil) =>
                tosend =
                    username: username
                    password: password
                    email: email
                callback = (data) ->
                    mediator.commands.execute 'signin'
                    mediator.commands.execute 'closemodal'
                ajaxutil.ajax 'signup',tosend,'POST',callback
        signIn: (username,password) ->
            require ['cs!app/utils/ajax'],(ajaxutil) =>
                tosend =
                    username: username
                    password: password
                callback = (data) ->
                    mediator.commands.execute 'signin'
                    mediator.commands.execute 'closemodal'

                ajaxutil.ajax 'signin',tosend,'POST',callback
    new UserHelper()
