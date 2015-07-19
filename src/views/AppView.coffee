class window.AppView extends Backbone.View
  template: _.template '
    <button disabled class="hit-button">Hit</button> 
    <button disabled class="stand-button">Stand</button>
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
    @dealView = new HandView(collection:@model.get 'dealerHand').el
    @handView = new HandView(collection:@model.get 'playerHand').el
    @render()
    (@model.get 'dealerHand').on 'compareScores', => @compareScores()
    (@model.get 'chipCount').on 'betSet', => @flipCards()

  toggleButtons: ->
    hitButton = $('.hit-button')
    standButton = $('.stand-button')
    if hitButton.attr('disabled')
      hitButton.attr('disabled', false)
      standButton.attr('disabled', false)
    else
      hitButton.attr('disabled', true)
      standButton.attr('disabled', true)


  render: ->
    # @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html @handView
    @$('.dealer-hand-container').html @dealView
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

  flipCards: ->
    @toggleButtons()
    playHand = @model.get 'playerHand' 
    dealHand = @model.get 'dealerHand'
    playHand.at(0).flip()
    playHand.at(1).flip()
    dealHand.at(1).flip()

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
    @flipCards()

    $('.hit-button').css('display', 'inline')
    $('.stand-button').css('display', 'inline')

    # @trigger 'reset'

    @render()

    # new AppView({
    #   model: new App()
    # }).$el.appendTo('body');
    # @render()
    
