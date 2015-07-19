// Generated by CoffeeScript 1.9.3
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.AppView = (function(superClass) {
    extend(AppView, superClass);

    function AppView() {
      return AppView.__super__.constructor.apply(this, arguments);
    }

    AppView.prototype.template = _.template('<button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="reset-button">Reset</button> <div class="player-hand-container"></div> <div class="dealer-hand-container"></div> <br> <h1 class="winner"></h1>');

    AppView.prototype.events = {
      'click .hit-button': function() {
        return this.model.get('playerHand').hit();
      },
      'click .stand-button': function() {
        return this.standClicked();
      },
      'click .reset-button': function() {
        return this.reset();
      }
    };

    AppView.prototype.initialize = function() {
      this.render();
      return (this.model.get('dealerHand')).on('compareScores', (function(_this) {
        return function() {
          return _this.compareScores();
        };
      })(this));
    };

    AppView.prototype.render = function() {
      this.$el.children().detach();
      this.$el.html(this.template());
      this.$('.player-hand-container').html(new HandView({
        collection: this.model.get('playerHand')
      }).el);
      return this.$('.dealer-hand-container').html(new HandView({
        collection: this.model.get('dealerHand')
      }).el);
    };

    AppView.prototype.standClicked = function() {
      this.model.get('dealerHand').at(0).flip();
      while ((this.model.get('dealerHand')).highestScore() < 17) {
        (this.model.get('dealerHand')).hit();
      }
      if ((this.model.get('dealerHand')).scores()[0] > 21) {
        $('.hit-button').remove();
        $('.stand-button').remove();
        $('.winner').text('Dealer bust. You win!');
        return setTimeout((function() {
          return $('.winner').css({
            'color': 'white'
          });
        }), 1600);
      } else {
        return this.compareScores();
      }
    };

    AppView.prototype.compareScores = function() {
      var dealHand, dealScore, playHand, playScore;
      playHand = this.model.get('playerHand');
      dealHand = this.model.get('dealerHand');
      playScore = playHand.highestScore();
      dealScore = dealHand.highestScore();
      $('.hit-button').remove();
      $('.stand-button').remove();
      if (playScore > dealScore) {
        $('.winner').text('You are the winner!');
        return setTimeout((function() {
          return $('.winner').css({
            'color': 'white'
          });
        }), 1600);
      } else if (dealScore > playScore) {
        $('.winner').text('Dealer is the winner.');
        return setTimeout((function() {
          return $('.winner').css({
            'color': 'white'
          });
        }), 1600);
      } else {
        $('.winner').text('It\'s a tie!');
        return setTimeout((function() {
          return $('.winner').css({
            'color': 'white'
          });
        }), 1600);
      }
    };

    AppView.prototype.reset = function() {
      $('body').html('');
      return new AppView({
        model: new App()
      }).$el.appendTo('body');
    };

    return AppView;

  })(Backbone.View);

}).call(this);

//# sourceMappingURL=AppView.js.map
