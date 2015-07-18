class window.BettingView extends Backbone.View
  template: _.template '<input> <button class="Bet">Bet</button> $<span class="chips"><%= chips %></span>'

  initialize: ->
    @render()

  events: 
    'keyup input': -> @updateChips() 
    'click .Bet': -> @setBet()


  render: ->
    @$el.html @template @model.attributes

  updateChips: ->
    chipDiff = @model.get('chips') - $('input').val()
    $('.chips').text(chipDiff)

  setBet: ->
    betted = $('input').val()
    @model.set('chips', @model.get('chips') - betted)
    $('input').val('')
    $('.chips').text(@model.get('chips'))
    $('.chips').after('<span><br><br>Betted: $' + betted + '</span>')