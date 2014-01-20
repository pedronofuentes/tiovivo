class Tiovivo
    constructor: (element) ->
        @$element = $(element)
        @$indicators = @$element.find(".slide-indicators").children()
        @$active = @$indicators.siblings ".active"
        @$slides = @$element.find ".slide"
        @interval = 
        @pause = false

        @$element.hover(
            @stop,
            @start
        )

        @$indicators.mouseenter @indicatorHovered

        @hideInactive()
        @start()
        
    hideInactive: ->
        @$slides.hide()
        $(@$slides.get(@$active.index())).show()

    start: =>
        @interval = setInterval(
            =>
                current = @$active.index()
                next = if (current + 1 < @$indicators.size()) then current + 1 else 0
                @setActive next
            , 5000)

    stop: =>
        console.log "Pausing!!"
        @pause = true
        clearInterval(@interval)

    resume: => 
        @pause = false
        @start()

    indicatorHovered: (event) =>
        $indicator = $(event.currentTarget)
        index = $indicator.index()
        @setActive index

    setActive: (index) ->
        @$active.removeClass "active"
        @$active = $(@$indicators.get(index)).addClass "active"
        @hideInactive()
