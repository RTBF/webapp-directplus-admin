define 'app/models/store', ['app/models/todo','ember'],(Todo) ->

  class Store
    constructor: (@name) ->
      store= localStorage.getItem(@name)
      @data = 

      # ...
    
  

