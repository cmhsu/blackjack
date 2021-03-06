class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  stand: ->
    @trigger 'stand' , @

  hit: ->
    @add(@deck.pop())
    $('.placeBet').attr('disabled', 'true')

  saveScore: ->
    @playerScore = @highestScore();  

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  highestScore: ->
    #take the highest of two scores
    # debugger;
    handScores = @scores()
    if handScores[1] <= 21
      return handScores[1]
    else
      return handScores[0]

