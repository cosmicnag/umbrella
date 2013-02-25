define ['marionette','require'],(Marionette,require) ->
    {
        "home":() =>
            require ['cs!app/helpers/book'],(bookhelper) ->
                bookhelper.renderHome()
        "query":(genre, author, lender, sort,query='') ->
            console.log "in"
            require ['cs!app/helpers/book'],(bookhelper) ->
                bookhelper.query(query, genre, author, lender, sort)
    }
