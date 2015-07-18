class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> 
    <button class="stand-button">Stand</button>
    <button class="reset-button">Reset</button>  
    <div class="betting-container"></div>  
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
    # @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.betting-container').html new BettingView(model: @model.get 'chipCount').el

  compareScores: ->
    playHand = @model.get 'playerHand' 
    dealHand = @model.get 'dealerHand'
    playScore = playHand.highestScore()
    dealScore = dealHand.highestScore()
    $('.hit-button').css('display', 'none')
    $('.stand-button').css('display', 'none')
    if playScore > dealScore
      setTimeout ( ->
        alert('You are the winner!')
      ), 2000
    else if dealScore > playScore
      setTimeout ( ->
        alert('Dealer is the winner.')
      ), 2000
    else
      setTimeout ( ->
        alert('It\'s a tie!')
      ), 2000
    # debugger;



  reset: ->
    # $('body').html('')
    @$('.player-hand-container').html('') 
    @$('.dealer-hand-container').html('') 
    @$('.betting-container').html('') 
    playHand = @model.get 'playerHand'
    playHand.reset()
    playHand.hit()
    playHand.hit()
    dealHand = @model.get 'dealerHand'
    dealHand.reset()
    dealHand.hit()
    dealHand.first().flip()
    dealHand.hit()

    $('.hit-button').css('display', 'inline')
    $('.stand-button').css('display', 'inline')

    @$('.player-hand-container').html new HandView(collection: playHand).el
    @$('.dealer-hand-container').html new HandView(collection: dealHand).el
    @$('.betting-container').html new BettingView(model: @model.get 'chipCount').el

    # new AppView({
    #   model: new App()
    # }).$el.appendTo('body');
    # @render()
    
