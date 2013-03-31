describe "testing places", ->
  done = false
  beforeEach ->
    require ["cs!app/collections/books"], (Books) =>
      options =
        query: ''
        author: 'all'
        genre: 'all'
        lender: 'all'
      @books = new Books([], options)
      @books.fetch()
      @books.on "reset", ->
        done = true


    waitsFor ->
      done


  it "should fetch > 0 books", ->
    expect(@books.length).toBeGreaterThan 0

