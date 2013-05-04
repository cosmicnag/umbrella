define ['chai', 'chai-backbone'], (chai, chaiBackbone) ->
    console.log chai
    chai.use(chaiBackbone)
    [assert, expect, should] = [chai.assert, chai.expect, chai.should]
    describe "testing books", ->
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
        expect(@books.length).to.be.above 0

