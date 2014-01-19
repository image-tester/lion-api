Notdvs.TasksController = Ember.ArrayController.extend(new Notdvs.Pusherable('task'),
  sortProperties: ['createdAt']
  sortAscending: false

  actions:
    createTask: ->
      title = undefined
      task = undefined

      title = @get('newTitle').trim()
      return unless title

      task = @store.createRecord('task',
        title: title
        clientId: new Date().getTime().toString()
      )

      @get('newRecords').pushObject(task)
      task.save()

      @set 'newTitle', ''

  remaining: (->
    @filterProperty('completed', false).get('length')
  ).property('@each.completed')

  remainingFormatted: (->
    remaining = @get('remaining')
    plural = if remaining == 1 then 'item' else 'items'
    '<strong>%@</strong> %@ left'.fmt(remaining, plural)
  ).property('remaining')
)