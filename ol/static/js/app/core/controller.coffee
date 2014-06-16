define ['marionette','require','jquery'],(Marionette,require,$) ->
    {
        "home":() =>
            require ['cs!app/helpers/book'],(bookhelper) ->
                bookhelper.renderHome()
        "query":(genre, author, lender, sort,query='') ->
            console.log "query controller called"
            require ['cs!app/helpers/book'],(bookhelper) ->
                bookhelper.query(query, genre, author, lender, sort)
        "lenders":(id=false) ->
            require ['cs!app/helpers/book','cs!app/ol', 'cs!app/views/lenders', 'cs!app/collections/lenders'],(bookHelper,OL, LendersView, Lenders) ->
                bookHelper.renderHome(false)
                if id
                  data = id: id
                else
                  data = {}
                $.getJSON "/api/lenders", data, (lenders) ->
                    collection = new Lenders(lenders)
                    view = new LendersView({collection: collection})
                    OL.content.currentView.books.show view
        "borrow":(id) ->
            require ['cs!app/models/book', 'cs!app/helpers/modal', 'cs!app/helpers/book'], (Book, modalHelper, bookHelper) ->
                bookHelper.renderHome()
                $.getJSON "/api/book/" + id + ".json", {}, (book) ->
                    bookModel = new Book(book)
                    modalHelper.showModal "borrow", bookModel
        "about":() ->
            require ['cs!app/views/about', 'cs!app/helpers/book'], (AboutView, bookHelper) ->
                bookHelper.renderHome()
                view = new AboutView()
                OL.content.currentView.books.show view
                

    }
