// Generated by CoffeeScript 1.4.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(['jquery', 'backbone', 'application/views/slideView'], function($, Backbone, SlideView) {
  var ConferenceView;
  return ConferenceView = (function(_super) {

    __extends(ConferenceView, _super);

    function ConferenceView() {
      return ConferenceView.__super__.constructor.apply(this, arguments);
    }

    ConferenceView.counter = 0;

    ConferenceView.prototype.tagName = 'li';

    ConferenceView.prototype.className = 'conf span4';

    ConferenceView.prototype.template = _.template($('#conf-template').html());

    ConferenceView.prototype.events = {
      'click .conf-item': 'choose',
      'click #deleteconf': 'deleteconf'
    };

    ConferenceView.prototype.initialize = function() {
      var _this = this;
      console.log("Counter: " + ConferenceView.counter);
      this.id = ConferenceView.counter;
      ConferenceView.counter++;
      this.listenTo(this.model, 'change', this.render);
      this.listenTo(this.model, 'change:slidesC', this.renderList);
      this.listenTo(this.model, 'new', function(data) {
        return _this.newSlide(data);
      });
      return this.listenTo(this.model, 'remove', this.remove);
    };

    ConferenceView.prototype.render = function() {
      this.$el.html(this.template(this.model.toJSON()));
      return this;
    };

    ConferenceView.prototype.renderList = function() {
      $('.Sent').children().remove();
      $('.toSend').children().remove();
      return this.model.get('slidesC').each(function(slide) {
        var slideView;
        slideView = new SlideView({
          model: slide
        });
        console.log(slideView);
        if (slide.get('sent')) {
          return $('.Sent').append(slideView.render().el);
        } else {
          return $('.toSend').append(slideView.render().el);
        }
      });
    };

    ConferenceView.prototype.newSlide = function(data) {
      var slide, slideView;
      console.log("render new");
      slide = data;
      slideView = new SlideView({
        model: slide
      });
      console.log(slideView);
      if (slide.get('sent')) {
        return $('.Sent').append(slideView.render().el);
      } else {
        return $('.toSend').append(slideView.render().el);
      }
    };

    ConferenceView.prototype.choose = function() {
      var href, id;
      $('.confList').trigger('conferenceChoosed', this.model.get('id'));
      id = this.model.get('id');
      console.log(id);
      href = '/anime/' + id;
      return Backbone.history.navigate(href, {
        trigger: true
      });
    };

    ConferenceView.prototype.deleteconf = function() {
      if (confirm("Are you sure?")) {
        return $('#deleteconf').trigger('deleteconf', this.model.get('id'));
      }
    };

    ConferenceView.prototype.remove = function() {
      var id;
      id = '#' + this.model.get('id');
      return $(id).parent().slideUp();
    };

    return ConferenceView;

  })(Backbone.View);
});
