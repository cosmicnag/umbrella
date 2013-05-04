define ['require','cs!app/core/mediator'],(require,mediator) ->
    class UserHelper
        signUp: (username,password,password2,email) ->
            require ['cs!app/utils/ajax'],(ajaxutil) =>
                tosend =
                    username: username
                    password: password
                    email: email
                success_callback = (data) ->
                    mediator.commands.execute 'signin'
                    mediator.commands.execute 'closemodal'
                error_callback = (data) ->
                    alert data.error
                ajaxutil.ajax 'signup',tosend,'POST',success_callback,error_callback
        signIn: (username,password) ->
            require ['cs!app/utils/ajax'],(ajaxutil) =>
                tosend =
                    username: username
                    password: password
                success_callback = (data) ->
                    mediator.commands.execute 'signin'
                    mediator.commands.execute 'closemodal'
                error_callback = (data) ->
                    alert data.error
                ajaxutil.ajax 'signin',tosend,'POST',success_callback,error_callback
    new UserHelper()
