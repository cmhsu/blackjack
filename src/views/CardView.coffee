class window.CardView extends Backbone.View
  className: 'card'

  # template: _.template '<%= rankName %> of <%= suitName %>'
  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png">'

  initialize: -> 
    @index = @model.collection.indexOf(@model);
    @render()

  render: ->
    @$el.children().remove()
    @$el.html @template @model.attributes
    if @index == @model.collection.length - 1
      @$el.addClass('wrapper')
      @$el.children().addClass('slide');  
    @$el.addClass 'covered' unless @model.get 'revealed'
    
