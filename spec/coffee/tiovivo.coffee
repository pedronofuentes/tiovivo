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
            expect(tiovivo.$indicators).toEqual $("#tiovivo .slide-indicators").children()

        it "gets the active item on construct", ->
            expect(tiovivo.$active).toEqual $("#tiovivo .slide-indicators .active")

        it "gets slides on construct", ->
            expect(tiovivo.$slides).toEqual $("#tiovivo .slide")

        it "hides slides not indicated as active", ->
            expect($("#tiovivo .slide:hidden").size()).toEqual 2

    describe "cycle", ->
        beforeEach ->
            jasmine.clock().install()

        afterEach ->
            jasmine.clock().uninstall()

        it "should change the active indicator", ->
            loadFixtures 'my-tiovivo.html'
            tiovivo = new Tiovivo $("#tiovivo")

            expect($("#tiovivo .slide-indicators .active").index()).toEqual 1
            jasmine.clock().tick(5001)
            expect($("#tiovivo .slide-indicators .active").index()).toEqual 2

        it "could be started from any active", ->
            loadFixtures 'my-tiovivo-active-first.html'
            tiovivo = new Tiovivo $("#tiovivo")

            expect($("#tiovivo .slide-indicators .active").index()).toEqual 0
            jasmine.clock().tick(5001)
            expect($("#tiovivo .slide-indicators .active").index()).toEqual 1

        it "should start from the first indicator when changes from last", ->
            loadFixtures 'my-tiovivo-active-last.html'
            tiovivo = new Tiovivo $("#tiovivo")

            expect($("#tiovivo .slide-indicators .active").index()).toEqual 2
            jasmine.clock().tick(5001)
            expect($("#tiovivo .slide-indicators .active").index()).toEqual 0

        it "should change active each interval", ->
            loadFixtures 'my-tiovivo-active-first.html'
            tiovivo = new Tiovivo $("#tiovivo")

            expect($("#tiovivo .slide-indicators .active").index()).toEqual 0
            jasmine.clock().tick(5001)
            expect($("#tiovivo .slide-indicators .active").index()).toEqual 1
            jasmine.clock().tick(5001)
            expect($("#tiovivo .slide-indicators .active").index()).toEqual 2
            jasmine.clock().tick(5001)
            expect($("#tiovivo .slide-indicators .active").index()).toEqual 0

        it "should show the corresponding slide", ->
            loadFixtures 'my-tiovivo-active-first.html'
            tiovivo = new Tiovivo $("#tiovivo")

            expect($("#tiovivo .slide:visible").index()). toEqual tiovivo.$active.index()
            jasmine.clock().tick(5001)
            expect($("#tiovivo .slide:visible").index()). toEqual tiovivo.$active.index()

    describe "pause state", ->
        tiovivo = undefined

        beforeEach ->
            jasmine.clock().install()

            loadFixtures 'my-tiovivo.html'
            tiovivo = new Tiovivo $("#tiovivo")

        afterEach ->
            jasmine.clock().uninstall()

        it "should pase when user puts mouse in the slider", ->
            expect($("#tiovivo .slide-indicators .active").index()).toEqual 1
            jasmine.clock().tick(5001)
            expect($("#tiovivo .slide-indicators .active").index()).toEqual 2
            tiovivo.$element.mouseenter()
            jasmine.clock().tick(5001)
            expect($("#tiovivo .slide-indicators .active").index()).toEqual 2

        it "should resume when mouse leaves the slider", ->
            tiovivo.$element.mouseenter()
            jasmine.clock().tick(5001)
            expect($("#tiovivo .slide-indicators .active").index()).toEqual 1

            tiovivo.$element.mouseleave()
            jasmine.clock().tick(5001)
            expect($("#tiovivo .slide-indicators .active").index()).toEqual 2

    describe "active hover", ->
        it "should show related slide when the mouse is over an indicator", ->
            loadFixtures 'my-tiovivo.html'
            tiovivo = new Tiovivo $("#tiovivo")

            $elementToHover = $($("#tiovivo .slide-indicators").children().get(2))
            $elementToHover.mouseenter()
            expect($("#tiovivo .slide:visible").index()).toEqual $elementToHover.index()

