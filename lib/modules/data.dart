import 'dart:async';

import '../.imports.dart';

class Data {
  static Map _data = {};

  static final StreamController _streamController = StreamController.broadcast();
  static Stream get stream => _streamController.stream;

  static void update(Map data) {
    _data = Tools.print(data, prefix: 'Data');

    //Users._update(app.loadMap(data, 'users', {}));
    //groups._update(app.loadMap(data, 'groups', {}));
  }

  static User getUser(String id) => User.fromMap(id, Tools.loadMap(_data, 'users/$id', {}));
}

class User {
  final String id;
  final String name;
  final List groups;

  User({required this.id, required this.name, required this.groups});

  factory User.fromMap(String id, Map user) {
    return User(
      id: id,
      name: Tools.loadString(user, 'name', ''),
      groups: Tools.loadList(user, 'groups', []),
    );
  }
}

class Group {
  final String id;
  final String name;
  final List lists;

  Group({required this.id, required this.name, required this.lists});

  factory Group.fromMap(String id, Map group) {
    return Group(
      id: id,
      name: Tools.loadString(group, 'name', ''),
      lists: [],
    );
  }
}

class GroupList {}

class ListProduct {}
