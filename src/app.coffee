
WorkingOnApp = =>

  origin = new Date("1/1/2000")

  addDays = (date, days) ->
    result = new Date date
    result.setDate result.getDate() + days
    return result

  Item = (desc) ->
    self = this instanceof Item ? this : Object.create(Item.prototype);
    self.addded = new Date()
    self.description = desc
    self.isDeleted = false
    self.expirationDate = addDays self.added, 1
    self.id = self.added - origin
    return self

  AddItem = (list, desc) ->
    item = new Item(desc)
    list[item.id] = item
    return list

  DeleteItem = (list, id) ->
    list[id] = null
    delete list[id]

  UpdateItemDescription = (list, id, desc) ->
    if list[id] != undefined
      list[id].description = desc

  UpdateItemExpirationDate = (list, id, date) ->
    if list[id] != undefined
      list[id].expirationDate = new Date(date)

  FetchList = (list) ->
    keys = Object.keys(list);
    readList = [];
    i = 0;
    keys.forEach (k) ->
      readList[i++] = list[k] if !list[k].isDeleted
    return readList

  return {
    Add: AddItem,
    Delete: DeleteItem,
    UpdateDate: UpdateItemExpirationDate,
    UpdateDescription: UpdateItemDescription,
    Fetch: FetchList
  }

window.App = =>

  getDescription = ->
    desc = document.getElemenetById 'description'
    return desc.innerHTML

  createListItem = ->
    li = document.createElement 'li'
    return li

  createDescSpan = (desc) ->
    span = document.createElement 'span'
    span.innerHTML = desc
    return span

  createDateSpan =(date) ->
    span = document.createElement 'span'
    span.innerHTML = date.toDateString()
    return span

  List = {}

  addNewWorkingItem = ->
    desc = getDescription()
    WorkingOnApp.Add List, desc
    return

  showList = ->
    list = WorkingOnApp.Fetch List;
    li = createListItem()
    desc = createDescSpan()
    li.appendChild desc
    document.getElementById 'list'
      .appendChild li
    return

  return {
    Fetch: showList,
    Add: addNewWorkingItem
  }
