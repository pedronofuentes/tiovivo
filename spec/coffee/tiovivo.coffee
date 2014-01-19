describe "Tiovivo class", ->
    it "should exist", ->
        tiovivo = new Tiovivo

        expect(tiovivo).toBeDefined()

    it "gets an element", ->
        element = $("<div id=\"#tiovivo\"></div>")
        tiovivo = new Tiovivo element

        expect(tiovivo.$element).toEqual(element);
