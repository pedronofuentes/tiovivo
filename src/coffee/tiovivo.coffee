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
        @setSlideActive()

        @start()
        
    setSlideActive: ->
        @$slides.removeClass('active')
        $(@$slides.get(@$active.index())).addClass('active')

    start: =>
        @interval = setInterval(
            =>
                current = @$active.index()
                next = if (current + 1 < @$indicators.size()) then current + 1 else 0
                @setActive next
            , 5000)

    stop: =>
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
        @setSlideActive()


$ = jQuery

$.fn.extend
    tiovivo: (options) ->
        this.each ->
            $this = $(this)
            data = $this.data('tiovivo')

            if not data
                $this.data 'tiovivo', (data = new Tiovivo this)


loadTiovivos = ->
    $('[data-component="tiovivo"]').each ->
        $(this).tiovivo()

$ ->
    loadTiovivos()
