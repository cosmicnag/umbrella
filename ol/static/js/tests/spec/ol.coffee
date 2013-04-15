define ['chai', 'chai-backbone', 'cs!app/ol'], (chai, chaiBackbone, OL) ->
    chai.use(chaiBackbone)
    [assert, expect, should] = [chai.assert, chai.expect, chai.should]

    describe "test main app functions", () ->
        it 'tests that tests work', ->
            assert(true)

        it 'tests that the router started', ->
            OL.router?

        it 'checks if regions have current views', ->
            OL.menu.currentView? and OL.content.currentView?
