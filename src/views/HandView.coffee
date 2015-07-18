class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    # debugger;
    @collection.on 'add remove change', => @render()
    @render()
    @collection.on 'add', => @checkBust()
    @collection.on 'stand', => @checkDealer()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.highestScore()

  # checkScore: (handScores)->
  #   if handScores[1] <= 21
  #     return handScores[1]
  #   else
  #     return handScores[0]

  checkBust: ->
    console.log('checkbust')
    if @collection.scores()[0] > 21 and !@collection.isDealer
      alert('You bust, you lose!')
  
  checkDealer: ->
    # highestScore = @collection.highestScore()
    # console.log(@collection.scores())

    @collection.at(0).flip()
    while @collection.highestScore() < 17
      @collection.hit()
    if @collection.scores()[0] > 21 
      alert('Dealer bust. You win!')
    else 
      console.log("score check triggered")
      @collection.trigger 'compareScores', @
    




    