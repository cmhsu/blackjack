class window.AppView extends Backbone.View
  className: 'appBody'

  template: _.template '
    <button class="hit-button">Hit</button> 
    <button class="stand-button">Stand</button>
    <button class="reset-button">Reset</button>
    <br><br>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <h1 class="winner"></h1>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @standClicked()
    'click .reset-button': -> @reset()

  initialize: ->
    @render()
    (@model.get 'dealerHand').on 'compareScores', => @compareScores()
#    (@model.get 'playerHand').on 'youLose', => @model.get('bet')
    console.log(@model)

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  standClicked: ->
    $('.hit-button').remove()
    $('.stand-button').remove()
    $('.placeBet').attr('disabled', 'true')
    @model.get('dealerHand').at(0).flip()

    getCard = =>
      setTimeout ( =>
        if (@model.get 'dealerHand').highestScore() < 17
          if !((@model.get 'playerHand').highestScore() < @model.get('dealerHand').minScore())
            (@model.get 'dealerHand').hit()
            getCard()
      ), 400

    getCard()

    setTimeout ( =>
      if (@model.get 'dealerHand').scores()[0] > 21
        $('.hit-button').remove()
        $('.stand-button').remove()
        $('.winner').text('Dealer bust. You win!')
        (@model.get 'bet').trigger('youWon')
        $('.winner').css('color': 'white')
      else
        @compareScores()
    ), 2000

  compareScores: ->
    playHand = @model.get 'playerHand'
    dealHand = @model.get 'dealerHand'
    playScore = playHand.highestScore()
    dealScore = dealHand.highestScore()
    $('.hit-button').remove()
    $('.stand-button').remove()
    if playScore > dealScore
      $('.winner').text('You are the winner!')
      $('.winner').css('color': 'white')
      (@model.get 'bet').trigger('youWon')
    else if dealScore > playScore
      $('.winner').text('Dealer is the winner.')
      $('.winner').css('color': 'white')
    else
      $('.winner').text('It\'s a tie!')
      $('.winner').css('color': 'white')
      (@model.get 'bet').trigger('youTied')

  reset: ->
    $('.appBody').html('');
    new AppView({
      model: new App()
    }).$el.appendTo('body');
    $('.placeBet').attr('disabled', false)
