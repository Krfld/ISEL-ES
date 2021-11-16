import '../.imports.dart';

class Data {
  static Map _data = {};

  static void update(Map data) {
    _data = data;
    Tools.msg(data, prefix: 'Data');

    //Users._update(app.loadMap(data, 'users', {}));
    //groups._update(app.loadMap(data, 'groups', {}));
  }
}

class User {
  final String _id;
  String get id => _id;

  final String _name;
  String get name => _name;

  User(this._id, this._name);

  static fromMap(String id, Map userData) {
    return User(id, '');
  }
}

class Group {}

class GroupList {}

class ListProduct {}
