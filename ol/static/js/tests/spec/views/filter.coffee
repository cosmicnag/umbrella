define ['chai', 'chai-backbone', 'cs!app/ol', 'jquery'], (chai, chaiBackbone, OL, $) ->
    chai.use(chaiBackbone)
    [assert, expect, should] = [chai.assert, chai.expect, chai.should]

    describe 'test filters', ->
        describe 'test setup', ->
            it 'should have loaded the filters', ->
                expect(OL.menu.currentView).to.be.ok

        describe 'test author', ->
            it 'should test ui.author', ->
                OL.menu.currentView.ui.author.val('test')
                val = $('#author').val()
                expect(val).to.equal('test')

            it 'tests autocomplete', ->
                OL.menu.currentView.ui.author.val('m')
                OL.menu.currentView.ui.author.trigger('typeahead:selected', {'value': 'Mark', 'tokens': ['Mark']})
                
             
    
