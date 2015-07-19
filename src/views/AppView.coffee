class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> 
    <button class="stand-button">Stand</button>
    <button class="reset-button">Reset</button>  
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <br>
    <h1 class="winner"></h1>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @standClicked()
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

  standClicked: ->
#    @model.get('dealerHand').stand()
    @model.get('dealerHand').at(0).flip()

    while (@model.get 'dealerHand').highestScore() < 17
      (@model.get 'dealerHand').hit()
    if (@model.get 'dealerHand').scores()[0] > 21
      $('.hit-button').remove()
      $('.stand-button').remove()
      $('.winner').text('Dealer bust. You win!')
    else
      @compareScores()

  compareScores: ->
    playHand = @model.get 'playerHand' 
    dealHand = @model.get 'dealerHand'
    playScore = playHand.highestScore()
    dealScore = dealHand.highestScore()
    $('.hit-button').remove()
    $('.stand-button').remove()
    if playScore > dealScore
      $('.winner').text('You are the winner!')
    else if dealScore > playScore
      $('.winner').text('Dealer is the winner.')
    else
      $('.winner').text('It\'s a tie!')
    # debugger;

  reset: ->
    $('body').html(''); 
    new AppView({
      model: new App()
    }).$el.appendTo('body');
