Notdvs.Store = DS.Store.extend()

Notdvs.ApplicationAdapter = DS.RESTAdapter.reopen
  namespace: 'api'

Notdvs.ApplicationSerializer = DS.ActiveModelSerializer.extend
  serialize: (record, options) ->
    json = @_super.apply(this, arguments)
    delete json.created_at
    json