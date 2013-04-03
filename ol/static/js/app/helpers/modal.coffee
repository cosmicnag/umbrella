define ['require', 'jquery'], (requirei, $) ->
    class ModalHelper
        
        showModal: (type,args...) ->
            @addCloseHandler()
            switch type
                when 'signup'
                    require ['cs!app/ol', 'jquery', 'cs!app/views/modals/signup'], (OL, $, SignupModalView) ->
                        $('.overlay').show()
                        OL.modal.show(new SignupModalView())
                when 'signin'
                    require ['cs!app/ol', 'jquery', 'cs!app/views/modals/signin'], (OL, $, SignInModalView) ->
                        $('.overlay').show()
                        OL.modal.show(new SignInModalView())
                when 'borrow'
                    require ['cs!app/ol', 'jquery', 'cs!app/views/modals/borrow','backbone'], (OL, $, BorrowModalView,Backbone) ->
                        $('.overlay').show()
                        console.log args[0]
                        OL.modal.show(new BorrowModalView({model: args[0]}))
        closeModal: () ->
            @removeCloseHandler()
            require ['cs!app/ol','jquery'],(OL,$) ->
                OL.modal.close()
                $('.overlay').hide()

        addCloseHandler: () ->
            $('.overlay').bind 'click', () ->
                $('.overlay').hide()
            $('.lightBoxContent').bind 'click', (e) ->
                e.stopPropagation()

        removeCloseHandler: () ->
            $('.overlay').unbind('click')
            $('.lightBoxContent').unbind('click')

    new ModalHelper()
