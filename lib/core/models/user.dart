class User {

  String _userId;
  String _name;
  String _email;
  

  Map<String, dynamic> toJson() {
    var userDetails = Map<String, dynamic>();
    userDetails['name'] = _name;
    userDetails['email'] = _email;

    if(_userId != null) userDetails['id'] = _userId;

    return userDetails;
  }

  User.fromJson(Map<String, dynamic> map) {
    this._userId = map['id'];
    this._name = map['name'];
    this._email = map['email'];
  }


}