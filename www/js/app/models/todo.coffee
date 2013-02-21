class Todo extends Spine.Model
  
  @configure "Todo" , "name" , "done"

  @extends Spine.Model.Store

  @active: ->
    @select (item)-> !item.done #what "done" is this? How does it works?

  @done: ->
    @select (item)-> !!item.done

  @destroyDone: ->
    rec.destroy() for rec in @done()
  
