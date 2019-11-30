class Note {
  String _title;
  String _description;
  int _id;
  String _stringId;
  int _priority;
  String _date;
  Note(this._title, this._date, this._priority, [this._description]);
  Note.withId(this._id, this._title, this._date, this._priority, [this._description]);

  String get title => _title;
  String get description => _description;
  String get date => _date;
  String get stringId => _stringId;

  int get id => _id;
  int get priority => _priority;


  set title(String newTitle) {
    this._title = newTitle;
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set description(String newDescription) {
    this._description = newDescription;
  }

  set priority(int newPriority) {
    if(newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  // set stringId(String id) {
  //   this._stringId = id;
  // }

   Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['title'] = this._title;
    map['description'] = this._description;
    map['priority'] = this._priority;
    map['date'] = this._date;

    if(_id != null) map['id'] = this._id;

    return map;
  }

  Note.fromMap(Map<String, dynamic> map, [String idString]) {
    this._stringId = idString;
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }

}