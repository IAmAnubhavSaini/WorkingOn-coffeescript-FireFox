
WorkingOnApp = ((_this) ->

  origin = new Date('1/1/2000')

  addDays = (date, days) ->
    result = undefined
    result = new Date(date)
    result.setDate result.getDate() + days
    result

  Item = (desc) ->
    self = Object.create(Item.prototype)
    self.added = new Date
    self.description = desc
    self.isDeleted = false
    self.expirationDate = addDays(self.added, 1)
    self.id = self.added - origin
    self

  AddItem = (list, desc) ->
    item = new Item(desc)
    list[item.id] = item
    list

  DeleteItem = (list, id) ->
    list[id] = null
    delete list[id]

  UpdateItemDescription = (list, id, desc) ->
    if list[id] != undefined
      return list[id].description = desc
    return

  UpdateItemExpirationDate = (list, id, date) ->
    if list[id] != undefined
      return list[id].expirationDate = new Date(date)
    return

  FetchList = (list) ->
    keys = Object.keys(list)
    readList = []
    i = 0
    keys.forEach (k) ->
      if !list[k].isDeleted
        return readList[i++] = list[k]
      return
    readList

  {
    Add: AddItem
    Delete: DeleteItem
    UpdateDate: UpdateItemExpirationDate
    UpdateDescription: UpdateItemDescription
    Fetch: FetchList
  }
)(this)

window.App = ((_this) ->

  getDescription = ->
    desc = document.getElementById('description').value
    document.getElementById('description').value = ''
    return desc

  createListItem = ->
    li = document.createElement('li')
    li

  createDescSpan = (desc) ->
    span = document.createElement('span')
    span.innerHTML = desc
    span.classList.add 'descSpan'
    span

  createDateSpan = (date) ->
    span = document.createElement('span')
    span.innerHTML = date.toDateString()
    span.classList.add 'dateSpan'
    span

  List = {}

  addNewWorkingItem = ->
    desc = getDescription()
    WorkingOnApp.Add(List, desc)
    showList()
    return

  showList = ->
    ul = document.getElementById('list')
    ul.innerHTML = ''
    list = WorkingOnApp.Fetch(List)
    if list.length > 0
      keys = Object.keys(list)
      i = keys.length-1
      while i >= 0
        li = createListItem()
        desc = createDescSpan(list[keys[i]].description)
        date = createDateSpan(list[keys[i]].expirationDate)
        li.appendChild desc
        li.appendChild date
        ul.appendChild li
        i--
    return

  (->
    document.getElementById('description').value = 'Working on Working-On project would be an example.'
    addNewWorkingItem()
    )();

  {
    Fetch: showList
    Add: addNewWorkingItem
  }
)(this)
