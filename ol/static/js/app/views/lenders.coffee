define ['marionette','cs!app/core/mediator', 'cs!app/views/lender'],(Marionette,mediator,LenderView) ->


    class LendersView extends Marionette.CollectionView
        itemView: LenderView
                
    LendersView
