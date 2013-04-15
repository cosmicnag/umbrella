define ['backbone','marionette','require','cs!app/ol','cs!app/core/globals'],(Backbone,Marionette,require,OL,globals) ->
  events = new Backbone.Wreqr.EventAggregator()
  commands = new Backbone.Wreqr.Commands()
  requests = new Backbone.Wreqr.RequestResponse()

  commands.addHandler "firequery",(querystring,genre,author,lender,sort) =>
    author = if author != '' then encodeURIComponent(author) else 'all'
    genre = if genre != '' then encodeURIComponent(genre) else 'all'
    console.log "author", author
    console.log "genre", genre
    if querystring != ''
        OL.router.navigate "genre/#{genre}/author/#{author}/lender/#{lender}/sort/#{sort}/query/#{querystring}",{trigger:true}
    else
        OL.router.navigate "genre/#{genre}/author/#{author}/lender/#{lender}/sort/#{sort}",{trigger:true}


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
    OL.menu.currentView.ui.querystring.val()

  requests.addHandler "issignedin",()->
    globals.get 'issignedin'

  {
    events : events
    commands : commands
    requests : requests
  }
