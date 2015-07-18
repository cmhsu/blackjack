class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    # debugger;
    @collection.on 'add remove change', => @render()
    @render()
    @collection.on 'add', => @checkBust()
    @collection.on 'stand', => @checkDealer()
    @collection.on 'reset', => @undelegate()

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
      $('.hit-button').css('display', 'none')
      $('.stand-button').css('display', 'none')
      setTimeout ( ->
        alert('You bust, you lose!')
      ), 2000
  checkDealer: ->
    # highestScore = @collection.highestScore()
    # console.log(@collection.scores())

    @collection.at(0).flip()
    @getCard = =>
      # debugger;
      if @collection.highestScore() < 17
        @collection.hit()
        setTimeout @getCard, 1000
    @getCard()
    if @collection.scores()[0] > 21 
      # $('.hit-button').css('visibility', 'hidden')
      # $('.stand-button').css('visibility', 'hidden')
      setTimeout ( ->
        alert('Dealer bust. You win!')
      ), 2000
    else
      @collection.trigger 'compareScores', @
    
  undelegate: ->
     # // COMPLETELY UNBIND THE VIEW
    @undelegateEvents();

    @$el.removeData().unbind(); 
    



    