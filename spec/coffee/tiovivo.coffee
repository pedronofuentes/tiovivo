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

        it "sets 'active' the related slide of the active indicator", ->
            expect(tiovivo.$slides.filter('.active').index()).toEqual $("#tiovivo .slide-indicators .active").index()
        
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

        it "sets 'active' the corresponding slide", ->
            loadFixtures 'my-tiovivo-active-first.html'
            tiovivo = new Tiovivo $("#tiovivo")

            expect($("#tiovivo .slide.active").index()). toEqual tiovivo.$active.index()
            jasmine.clock().tick(5001)
            expect($("#tiovivo .slide.active").index()). toEqual tiovivo.$active.index()

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
        it "should set as 'active' related slide when the mouse is over an indicator", ->
            loadFixtures 'my-tiovivo.html'
            tiovivo = new Tiovivo $("#tiovivo")

            $elementToHover = $($("#tiovivo .slide-indicators").children().get(2))
            $elementToHover.mouseenter()
            expect($("#tiovivo .slide.active").index()).toEqual $elementToHover.index()

describe "Tiovivo plugin", ->
    it "should append Tiovivo instance to data", ->
        loadFixtures 'my-tiovivo.html'

        $tiovivoElement = $("#tiovivo").tiovivo()

        expect($tiovivoElement.data('tiovivo')).toBeDefined()
        expect($tiovivoElement.data('tiovivo').$element).toEqual $("#tiovivo")

    it "should work with various 'tiovivos'", ->
        loadFixtures 'tiovivos.html'

        $tiovivoElements = $(".tiovivo").tiovivo()

        $tiovivoElements.each (index) ->
            $this = $(this)
            
            expect($this.data('tiovivo')).toBeDefined()
            expect($this.data('tiovivo').$element).toEqual $($(".tiovivo").get(index))

    describe "data attributes API", ->
        it "should initialize components indicated with data attributes", ->
            loadFixtures 'my-tiovivo-data-attribute.html'

            loadTiovivos()

            $tiovivoElement = $("#tiovivo");

            expect($tiovivoElement.data('tiovivo')).toBeDefined()
            expect($tiovivoElement.data('tiovivo').$element).toEqual $("#tiovivo")

        it "should work with various 'tiovivos'", ->
            loadFixtures 'tiovivos-data-attribute.html'

            loadTiovivos()

            $tiovivoElements = $(".tiovivo");

            $tiovivoElements.each (index) ->
                $this = $(this)
                
                expect($this.data('tiovivo')).toBeDefined()
                expect($this.data('tiovivo').$element).toEqual $($(".tiovivo").get(index))
