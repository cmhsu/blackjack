class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> 
    <button class="stand-button">Stand</button>
    <button class="reset-button">Reset</button>  
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('dealerHand').stand()
    # 'click .stand-button': -> @model.get('playerHand').saveScore()

  initialize: ->
    @render()
    (@model.get 'dealerHand').on 'compareScores', => @compareScores()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  compareScores: ->
    playHand = @model.get 'playerHand' 
    dealHand = @model.get 'dealerHand'
    playScore = playHand.highestScore()
    dealScore = dealHand.highestScore()
    if playScore > dealScore
      alert('You are the winner!')
    else if dealScore > playScore
      alert('Dealer is the winner.')
    else
      alert('It\'s a tie!')
    # debugger;
