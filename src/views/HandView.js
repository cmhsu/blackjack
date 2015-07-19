// Generated by CoffeeScript 1.9.3
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.HandView = (function(superClass) {
    extend(HandView, superClass);

    function HandView() {
      return HandView.__super__.constructor.apply(this, arguments);
    }

    HandView.prototype.className = 'hand';

    HandView.prototype.template = _.template('<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>');

    HandView.prototype.initialize = function() {
      this.collection.on('add remove change', (function(_this) {
        return function() {
          return _this.render();
        };
      })(this));
      this.render();
      this.collection.on('add', (function(_this) {
        return function() {
          return _this.checkBust();
        };
      })(this));
      return this.collection.on('stand', (function(_this) {
        return function() {
          return _this.checkDealer();
        };
      })(this));
    };

    HandView.prototype.render = function() {
      this.$el.children().detach();
      this.$el.html(this.template(this.collection));
      this.$el.append(this.collection.map(function(card) {
        return new CardView({
          model: card
        }).$el;
      }));
      return this.$('.score').text(this.collection.highestScore());
    };

    HandView.prototype.checkBust = function() {
      if (this.collection.scores()[0] > 21 && !this.collection.isDealer) {
        $('.hit-button').remove();
        $('.stand-button').remove();
        return $('.winner').text('You bust, you lose!');
      }
    };

    return HandView;

  })(Backbone.View);

}).call(this);

//# sourceMappingURL=HandView.js.map
