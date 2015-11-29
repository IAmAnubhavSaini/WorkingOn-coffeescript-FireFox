'use strict'

WorkingOnApp = =>

    addDays = (date, days) ->
      result = new Date date
      result.setDate result.getDate() + days
      return result

    origin = new Date("1/1/2000")

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
      readList = {};
      keys.forEach (k) ->
        readList[k] = list[k] if !list[k].isDeleted
      return readList

    return {
      Add: AddItem, Delete: DeleteItem, UpdateDate: UpdateItemExpirationDate, UpdateDescription: UpdateItemDescription,
      Fetch: FetchList
    }
