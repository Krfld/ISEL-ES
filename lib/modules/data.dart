import '../.imports.dart';

class Data {
  static Map _data = {};

  static void update(Map data) {
    _data = data;
    app.msg(data, prefix: 'Data');

    //Users._update(app.loadMap(data, 'users', {}));
    //groups._update(app.loadMap(data, 'groups', {}));
  }

  static getUser(String id) => User.fromMap(id, app.loadMap(_data, 'users/$id', {}));
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

class List {}

class Product {}
