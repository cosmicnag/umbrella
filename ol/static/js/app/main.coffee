define ['Backbone','domReady','cs!app/models/book','cs!app/collections/books','cs!app/views/booksview','jquery'],(Backbone,domReady,Book,Books,BooksView,$)->
  domReady ()->
    console.log "app initialized"
    books = new Books
    booksview = new BooksView
       collection:books
    books.fetch()
  
