describe "Tiovivo class", ->
    describe "initialization", ->

        tiovivo = undefined
        element = undefined

        beforeEach ->
            jasmine.getFixtures().fixturesPath = 'fixtures'
            jasmine.clock().install()
            
            loadFixtures 'my-tiovivo.html'

            element = $("#tiovivo")
            tiovivo = new Tiovivo element

        afterEach ->
            jasmine.clock().uninstall()

        it "should exist", ->
            expect(tiovivo).toBeDefined()

        it "gets an element", ->
            expect(tiovivo.$element).toEqual element;

        it "gets slide indicators", ->
            expect(tiovivo.$indicators).toEqual $("#tiovivo .slide-indicators")

        it "gets the active item on construct", ->
            expect(tiovivo.$active).toEqual $("#tiovivo .slide-indicators .active")

        it "gets slides on construct", ->
            expect(tiovivo.$slides).toEqual $("#tiovivo .slide")

        it "hides slides not indicated as active", ->
            expect($("#tiovivo .slide:hidden").size()).toEqual 2
