class window.BetView extends Backbone.View
  className: 'betting'

  template: _.template '
    <input class="betInput">
    <button class="placeBet">Place Bet</button><br><br>' +
    ' Chip Count:' + ' $<span class="moneyLeft"><%= money %>.</span>
    Bet: $<%= betAmount %>
    <br><br>
  '

  initialize: ->
    @render()
    @model.on 'youWon', => @youWon()
    @model.on 'youTied', => @youTied()
    @model.on 'resetBet', => @resetBet()

  events:
#   'keydown .betInput': 'updateOnKeyDown'
    'click .placeBet': 'betPlaced'

  render: ->
    @$el.html @template @model.attributes

  updateOnKeyDown: ->
    @model.set('money', @model.get('money') - $('.betInput').val())

  resetBet: ->
    @model.set('betAmount', 0)
    @render()

  betPlaced: ->
    amountBet = $('.betInput').val()
    if isNaN(amountBet) or amountBet < 0
      alert('Please enter a valid number.')
    else if @model.get('money') < amountBet
      alert('You don\'t have that many chips')
    else
      @model.set('money', @model.get('money') - amountBet)
      @model.set('betAmount', amountBet)
      @render()
      $('.placeBet').attr('disabled', true)

  youWon: ->
    @model.set('money', +@model.get('money') + (+@model.get('betAmount') * 2))
    @render()
    $('.placeBet').attr('disabled', true)

  youTied: ->
    @model.set('money', +@model.get('money') + (+@model.get('betAmount')))
    @render()
    $('.placeBet').attr('disabled', true)