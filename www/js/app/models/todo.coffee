define 'app/models/todo', ['ember'], ->

  class todo extends Ember.Object
    id: null
    title: null
    completed: false
    store: null

    constructor: (args) ->
      super(args)
      @addObserver('title',@todoChanged)
      @addObserver('completed',@todoChanged)

    todoChanged : ->
      @get('store').update(@)
    
  