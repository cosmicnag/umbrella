define ['backbone','marionette','require','cs!app/ol'],(Backbone,Marionette,require,OL) ->
  events = new Backbone.Wreqr.EventAggregator()
  commands = new Backbone.Wreqr.Commands()
  requests = new Backbone.Wreqr.RequestResponse()

  commands.addHandler "firequery",(querystring,genre,author,lender,sort) =>
    if querystring != ''
        OL.router.navigate "genre/#{genre}/author/#{author}/lender/#{lender}/sort/#{sort}/query/#{querystring}",{trigger:true}
    else
        OL.router.navigate "genre/#{genre}/author/#{author}/lender/#{lender}/sort/#{sort}",{trigger:true}

  requests.addHandler "querystring",()->
    OL.menu.currentView.ui.querystring.val()

  {
    events : events
    commands : commands
    requests : requests
  }
