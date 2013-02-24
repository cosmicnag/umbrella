define ['marionette','tpl!app/views/layouts/content.tpl'],(Marionette,template) ->
    class ContentLayout extends Marionette.Layout
        template: template
        regions:
            filter: '#sortViewsBlock'
            books: '#browseBlock'
    ContentLayout
