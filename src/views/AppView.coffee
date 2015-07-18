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
    'click .reset-button': -> @reset()
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
    $('.hit-button').remove()
    $('.stand-button').remove()
    if playScore > dealScore
      setTimeout ( ->
        alert('You are the winner!')
      ), 15
    else if dealScore > playScore
      setTimeout ( ->
        alert('Dealer is the winner.')
      ), 5
    else
      setTimeout ( ->
        alert('It\'s a tie!')
      ), 5
    # debugger;

  reset: ->
    $('body').html(''); 
    new AppView({
      model: new App()
    }).$el.appendTo('body');
