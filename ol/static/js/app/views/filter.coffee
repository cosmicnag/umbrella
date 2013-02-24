define ['marionette','tpl!app/views/filter.tpl'],(Marionette,template) ->
    class FilterView extends Marionette.ItemView
        template: template
    FilterView
