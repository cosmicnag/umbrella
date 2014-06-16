define ['marionette','tpl!app/views/menu.tpl', 'cs!app/helpers/book', 'cs!app/core/mediator'],(Marionette, template, BookHelper, mediator) ->
    class MenuView extends Marionette.ItemView
        template:template
        initialize:(options) ->
            super(options)
            @listenTo mediator.events, "search:queried", (queryObj) =>
                @ui.querystring.val(queryObj.query)
            @listenTo mediator.events, "signedin", () =>
                @ui.userBtns.text("Signed in")

        ui:
            querystring: '#querystring'
            userBtns: '.userBtns'
        events:
            'submit #searchForm': 'submitSearch'
            'click #signupBtn': 'signup'
            'click #signinBtn': 'signin'
            'click .mailModal': 'mail'
            'click #lendersBtn': 'lenders'
            'click .creditsModal': 'credits'
            'click #aboutBtn': 'about'

        submitSearch: (e) ->
            e.preventDefault()
            console.log(BookHelper)
            BookHelper.fireQuery() #TODO: pass args

        signup: (e) ->
            e.preventDefault()
            mediator.commands.execute "modal", "signup"

        signin: (e) ->
            e.preventDefault()
            mediator.commands.execute "modal", "signin"

        mail: (e) ->
            e.preventDefault()
            mediator.commands.execute "modal", "mail"

        credits: (e) ->
            e.preventDefault()
            mediator.commands.execute "modal", "credits"

        lenders: (e) ->
            e.preventDefault()
            OL = require('cs!app/ol')
            OL.router.navigate("lenders", {trigger: true})

        about: (e) ->
            e.preventDefault()
            OL = require('cs!app/ol')
            OL.router.navigate("about", {trigger: true})
