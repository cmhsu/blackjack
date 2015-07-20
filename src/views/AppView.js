// Generated by CoffeeScript 1.9.3
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.AppView = (function(superClass) {
    extend(AppView, superClass);

    function AppView() {
      return AppView.__super__.constructor.apply(this, arguments);
    }

    AppView.prototype.className = 'appBody';

    AppView.prototype.template = _.template('<button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="reset-button">Reset</button> <br><br> <div class="player-hand-container"></div> <div class="dealer-hand-container"></div> <h1 class="winner"></h1>');

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
      (this.model.get('dealerHand')).on('compareScores', (function(_this) {
        return function() {
          return _this.compareScores();
        };
      })(this));
      return console.log(this.model);
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
      var getCard;
      $('.hit-button').remove();
      $('.stand-button').remove();
      $('.placeBet').attr('disabled', 'true');
      this.model.get('dealerHand').at(0).flip();
      getCard = (function(_this) {
        return function() {
          return setTimeout((function() {
            if ((_this.model.get('dealerHand')).highestScore() < 17) {
              if (!((_this.model.get('playerHand')).highestScore() < _this.model.get('dealerHand').minScore())) {
                (_this.model.get('dealerHand')).hit();
                return getCard();
              }
            }
          }), 400);
        };
      })(this);
      getCard();
      return setTimeout(((function(_this) {
        return function() {
          if ((_this.model.get('dealerHand')).scores()[0] > 21) {
            $('.hit-button').remove();
            $('.stand-button').remove();
            $('.winner').text('Dealer bust. You win!');
            (_this.model.get('bet')).trigger('youWon');
            return $('.winner').css({
              'color': 'white'
            });
          } else {
            return _this.compareScores();
          }
        };
      })(this)), 2000);
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
        $('.winner').css({
          'color': 'white'
        });
        return (this.model.get('bet')).trigger('youWon');
      } else if (dealScore > playScore) {
        $('.winner').text('Dealer is the winner.');
        return $('.winner').css({
          'color': 'white'
        });
      } else {
        $('.winner').text('It\'s a tie!');
        $('.winner').css({
          'color': 'white'
        });
        return (this.model.get('bet')).trigger('youTied');
      }
    };

    AppView.prototype.reset = function() {
      $('.appBody').html('');
      new AppView({
        model: new App()
      }).$el.appendTo('body');
      return $('.placeBet').attr('disabled', false);
    };

    return AppView;

  })(Backbone.View);

}).call(this);

//# sourceMappingURL=AppView.js.map
