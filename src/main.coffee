window.bet = new Bet()
window.betView = new BetView(model: bet).$el.appendTo 'body'

new AppView(model: new App()).$el.appendTo 'body'

