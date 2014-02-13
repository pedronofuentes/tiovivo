/* tiovivo v0.4.0 - 2014/2/13
   http://github.com/pedronofuentes/tiovivo
   Copyright (c) 2014 Pedro Nofuentes <pedro.nofuentes@gmail.com> - Licensed MIT 
*/
var $, Tiovivo, loadTiovivos,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Tiovivo = (function() {
  function Tiovivo(element) {
    this.indicatorHovered = __bind(this.indicatorHovered, this);
    this.resume = __bind(this.resume, this);
    this.stop = __bind(this.stop, this);
    this.start = __bind(this.start, this);
    this.$element = $(element);
    this.$indicators = this.$element.find(".slide-indicators").children();
    this.$active = this.$indicators.siblings(".active");
    this.$slides = this.$element.find(".slide");
    this.interval = this.pause = false;
    this.$element.hover(this.stop, this.start);
    this.$indicators.mouseenter(this.indicatorHovered);
    this.setSlideActive();
    this.start();
  }

  Tiovivo.prototype.setSlideActive = function() {
    this.$slides.removeClass('active');
    return $(this.$slides.get(this.$active.index())).addClass('active');
  };

  Tiovivo.prototype.start = function() {
    var _this = this;
    return this.interval = setInterval(function() {
      var current, next;
      current = _this.$active.index();
      next = current + 1 < _this.$indicators.size() ? current + 1 : 0;
      return _this.setActive(next);
    }, 5000);
  };

  Tiovivo.prototype.stop = function() {
    this.pause = true;
    return clearInterval(this.interval);
  };

  Tiovivo.prototype.resume = function() {
    this.pause = false;
    return this.start();
  };

  Tiovivo.prototype.indicatorHovered = function(event) {
    var $indicator, index;
    $indicator = $(event.currentTarget);
    index = $indicator.index();
    return this.setActive(index);
  };

  Tiovivo.prototype.setActive = function(index) {
    this.$active.removeClass("active");
    this.$active = $(this.$indicators.get(index)).addClass("active");
    return this.setSlideActive();
  };

  return Tiovivo;

})();

$ = jQuery;

$.fn.extend({
  tiovivo: function(options) {
    return this.each(function() {
      var $this, data;
      $this = $(this);
      data = $this.data('tiovivo');
      if (!data) {
        return $this.data('tiovivo', (data = new Tiovivo(this)));
      }
    });
  }
});

loadTiovivos = function() {
  return $('[data-component="tiovivo"]').each(function() {
    return $(this).tiovivo();
  });
};

$(function() {
  return loadTiovivos();
});
