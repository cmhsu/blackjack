class window.BetView extends Backbone.View
  className: 'betting'

  template: _.template '
    <input class="betInput">
    <button class="placeBet">Place Bet</button>' +
    ' Chip Count:' + ' $<span class="moneyLeft"><%= money %></span>
    <br><br>
  '

  initialize: ->
    @render()
    @model.on 'youWon', => @youWon()
    @model.on 'youTied', => @youTied()

  events:
#   'keydown .betInput': 'updateOnKeyDown'
    'click .placeBet': 'betPlaced'

  render: ->
    @$el.html @template @model.attributes

  updateOnKeyDown: ->
    @model.set('money', @model.get('money') - $('.betInput').val())

  betPlaced: ->
    amountBet = $('.betInput').val()
    @model.set('money', @model.get('money') - amountBet)
    @model.set('betAmount', amountBet)
    @render()
    $('.placeBet').attr('disabled', true)

  youWon: ->
    @model.set('money', @model.get('money') + (@model.get('betAmount') * 2))
    @render()
    $('.placeBet').attr('disabled', true)

  youTied: ->
    @model.set('money', @model.get('money') + (@model.get('betAmount')))
    @render()
    $('.placeBet').attr('disabled', true)