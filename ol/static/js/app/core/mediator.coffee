define ['backbone','marionette','require'],(Backbone,Marionette,require) ->
  events = new Backbone.Wreqr.EventAggregator()
  commands = new Backbone.Wreqr.Commands()
  requests = new Backbone.Wreqr.RequestResponse()

  {
    events : events
    commands : commands
    requests : requests
  }
