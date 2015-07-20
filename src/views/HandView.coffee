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
    if @collection.scores()[0] > 21 and !@collection.isDealer
      $('.winner').text('You bust, you lose!')
      setTimeout ( ->
        $('.winner').css('color': 'white')
        $('.hit-button').remove()
        $('.stand-button').remove()
        return
      ), 1300
#  checkDealer: ->
    # highestScore = @collection.highestScore()
    # console.log(@collection.scores())

#    @$('.score').text @collection.highestScore()
#    @collection.at(0).flip()

#    @getCard = =>
#      # debugger;
#      if @collection.highestScore() < 17
#        @collection.hit()
#        setTimeout @getCard, 1000
#    @getCard()


#    while @collection.highestScore() < 17
#      @collection.hit()
#    if @collection.scores()[0] > 21
#      $('.hit-button').remove()
#      $('.stand-button').remove()
#      setTimeout ( ->
#        alert('Dealer bust. You win!')
#      ), 1100
#    else
#      @collection.trigger 'compareScores', @
    




    