class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    # debugger;
    @collection.on 'add remove change', => @render()
    @render()
    @collection.on 'add', => @checkBust()
    @collection.on 'stand', => @checkDealer()
    @$('.score').text(0)

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.highestScore()

  checkBust: ->
    if @collection.scores()[0] > 21 and !@collection.isDealer
      $('.hit-button').remove()
      $('.stand-button').remove()
      $('.winner').text('You bust, you lose!')
      @collection.trigger 'youLose'
      setTimeout ( ->
        $('.winner').css('color': 'white')
        return
      ), 1300




    