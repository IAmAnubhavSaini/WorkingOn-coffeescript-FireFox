(function() {
  var WorkingOnApp;

  WorkingOnApp = (function(_this) {
    var AddItem, DeleteItem, FetchList, Item, UpdateItemDescription, UpdateItemExpirationDate, addDays, origin;
    origin = new Date('1/1/2000');
    addDays = function(date, days) {
      var result;
      result = void 0;
      result = new Date(date);
      result.setDate(result.getDate() + days);
      return result;
    };
    Item = function(desc) {
      var self;
      self = Object.create(Item.prototype);
      self.added = new Date;
      self.description = desc;
      self.isDeleted = false;
      self.expirationDate = addDays(self.added, 1);
      self.id = self.added - origin;
      return self;
    };
    AddItem = function(list, desc) {
      var item;
      item = new Item(desc);
      list[item.id] = item;
      return list;
    };
    DeleteItem = function(list, id) {
      list[id] = null;
      return delete list[id];
    };
    UpdateItemDescription = function(list, id, desc) {
      if (list[id] !== void 0) {
        return list[id].description = desc;
      }
    };
    UpdateItemExpirationDate = function(list, id, date) {
      if (list[id] !== void 0) {
        return list[id].expirationDate = new Date(date);
      }
    };
    FetchList = function(list) {
      var i, keys, readList;
      keys = Object.keys(list);
      readList = [];
      i = 0;
      keys.forEach(function(k) {
        if (!list[k].isDeleted) {
          return readList[i++] = list[k];
        }
      });
      return readList;
    };
    return {
      Add: AddItem,
      Delete: DeleteItem,
      UpdateDate: UpdateItemExpirationDate,
      UpdateDescription: UpdateItemDescription,
      Fetch: FetchList
    };
  })(this);

  window.App = (function(_this) {
    var List, addNewWorkingItem, createDateSpan, createDescSpan, createListItem, getDescription, showList;
    getDescription = function() {
      var desc;
      desc = document.getElementById('description').value;
      document.getElementById('description').value = '';
      return desc;
    };
    createListItem = function() {
      var li;
      li = document.createElement('li');
      return li;
    };
    createDescSpan = function(desc) {
      var span;
      span = document.createElement('span');
      span.innerHTML = desc;
      span.classList.add('descSpan');
      return span;
    };
    createDateSpan = function(date) {
      var span;
      span = document.createElement('span');
      span.innerHTML = date.toDateString();
      span.classList.add('dateSpan');
      return span;
    };
    List = {};
    addNewWorkingItem = function() {
      var desc;
      desc = getDescription();
      WorkingOnApp.Add(List, desc);
      showList();
    };
    showList = function() {
      var date, desc, i, keys, li, list, ul;
      ul = document.getElementById('list');
      ul.innerHTML = '';
      list = WorkingOnApp.Fetch(List);
      if (list.length > 0) {
        keys = Object.keys(list);
        i = keys.length - 1;
        while (i >= 0) {
          li = createListItem();
          desc = createDescSpan(list[keys[i]].description);
          date = createDateSpan(list[keys[i]].expirationDate);
          li.appendChild(desc);
          li.appendChild(date);
          ul.appendChild(li);
          i--;
        }
      }
    };
    (function() {
      document.getElementById('description').value = 'Working on Working-On project would be an example.';
      return addNewWorkingItem();
    })();
    return {
      Fetch: showList,
      Add: addNewWorkingItem
    };
  })(this);

}).call(this);
