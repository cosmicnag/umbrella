define ['Backbone','domReady','cs!app/models/book','cs!app/collections/books','cs!app/views/booksview','jquery'],(Backbone,domReady,Book,Books,BooksView,$)->
  domReady ()->
    console.log "shit sort've works"
    books = new Books
    #books.url = "/api/books"
    books.fetch()
    #  console.log "done fetching"
    #  window.books = books
    #  booksview = new BooksView
    #    collection:books
    #  window.booksview = booksview
    #  booksview.render()
    #$("#content").append(booksview.render().el)
  
