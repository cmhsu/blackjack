// Generated by CoffeeScript 1.9.3
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.App = (function(superClass) {
    extend(App, superClass);

    function App() {
      return App.__super__.constructor.apply(this, arguments);
    }

    App.prototype.initialize = function() {
      var deck;
      this.set('deck', deck = new Deck());
      this.set('playerHand', deck.dealPlayer());
<<<<<<< HEAD
      this.set('dealerHand', deck.dealDealer());
      return this.set('chipCount', new ChipCount());
=======
      return this.set('dealerHand', deck.dealDealer());
>>>>>>> startedOver
    };

    return App;

  })(Backbone.Model);

}).call(this);

//# sourceMappingURL=App.js.map
