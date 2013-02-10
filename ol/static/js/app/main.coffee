define ['Backbone','domReady','cs!app/models/book','cs!app/collections/books','cs!app/views/booksview','jquery'],(Backbone,domReady,Book,Books,BooksView,$)->
  domReady ()->
    books = new Books
    books.url = "/api/books"
    books.fetch()
    booksview = new BooksView
      collection:books
    window.booksview = booksview
    $("#content").append(booksview.render().el)
  
