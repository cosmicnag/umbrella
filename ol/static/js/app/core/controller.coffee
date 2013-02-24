define ['marionette','require'],(Marionette,require) ->
    {
        "home":() =>
            require ['cs!app/helpers/book'],(bookhelper) ->
                bookhelper.renderHome()
    }
