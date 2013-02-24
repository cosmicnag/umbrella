define ['backbone','marionette','require','cs!app/ol'],(Backbone,Marionette,require,OL) ->
  events = new Backbone.Wreqr.EventAggregator()
  commands = new Backbone.Wreqr.Commands()
  requests = new Backbone.Wreqr.RequestResponse()

  requests.addHandler "querystring",()->
    OL.menu.currentView.ui.querystring.val()

  {
    events : events
    commands : commands
    requests : requests
  }
