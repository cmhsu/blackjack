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
    @model.set('chips', @model.get('chips') - $('input').val())
    $('input').val('')
    $('.chips').text(@model.get('chips'))
    console.log(@model.get('chips'))