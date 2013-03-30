define [],() ->
    class Settings
        endpoints:
            signup: 'signup'
            signin: 'signin'
            borrow: 'borrow'
        getAPIEndPoint:(route) ->
            "api/#{@endpoints[route]}"
    new Settings()
