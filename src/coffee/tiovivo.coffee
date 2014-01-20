class Tiovivo
    constructor: (element) ->
        @$element = $(element)
        @$indicators = @$element.find ".slide-indicators"
        @$active = @$indicators.find ".active"
        @$slides = @$element.find ".slide"

        @hideInactive()
        
    hideInactive: ->
        @$slides.hide()
        $(@$slides.get(@$active.index())).show()
