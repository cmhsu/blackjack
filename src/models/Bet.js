// Generated by CoffeeScript 1.9.3
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.Bet = (function(superClass) {
    extend(Bet, superClass);

    function Bet() {
      return Bet.__super__.constructor.apply(this, arguments);
    }

    Bet.prototype.initialize = function(params) {
      return this.set({
        money: 5000,
        betAmount: 0
      });
    };

    return Bet;

  })(Backbone.Model);

}).call(this);

//# sourceMappingURL=Bet.js.map
