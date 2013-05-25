define ['backbone','marionette','require','jquery','cs!app/ol','cs!app/core/globals'],(Backbone,Marionette,require,$,OL,globals) ->
  events = new Backbone.Wreqr.EventAggregator()
  commands = new Backbone.Wreqr.Commands()
  requests = new Backbone.Wreqr.RequestResponse()

  commands.addHandler "firequery",(querystring,genre,author,lender,sort) =>
    author = if author != '' then encodeURIComponent(author) else 'all'
    genre = if genre != '' then encodeURIComponent(genre) else 'all'
    querystring = encodeURIComponent(querystring)
    console.log "author", author
    console.log "genre", genre
    if querystring != ''
        OL.router.navigate "genre/#{genre}/author/#{author}/lender/#{lender}/sort/#{sort}/query/#{querystring}",{trigger:true}
    else
        OL.router.navigate "genre/#{genre}/author/#{author}/lender/#{lender}/sort/#{sort}",{trigger:true}

  commands.addHandler "search:doLoading", () ->
    $('#resultsLoading').css({'visibility': 'visible'})

  commands.addHandler "search:stopLoading", () ->
    $('#resultsLoading').css({'visibility': 'hidden'})

  commands.addHandler "modal", (type,args...)=>
    require ["cs!app/helpers/modal"], (modalHelper) =>
      modalHelper.showModal type,args...

  commands.addHandler 'closemodal',() =>
    require ['cs!app/helpers/modal'],(modalHelper) =>
      modalHelper.closeModal()

  commands.addHandler "signin",() ->
    globals.set 'issignedin',true
    events.trigger "signedin"

  requests.addHandler "querystring",()->
    OL.content.currentView.filter.currentView.ui.querystring.val()

  requests.addHandler "issignedin",()->
    globals.get 'issignedin'

  {
    events : events
    commands : commands
    requests : requests
  }
