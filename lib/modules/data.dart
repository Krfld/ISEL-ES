import 'package:flutter/foundation.dart';

import '../.imports.dart';

class Data {
  static Map _users = {};
  static Map _data = {};

  static String? _currentGroup;
  static String? _currentList;

  static Stream<Map> get usersStream => DB.stream('users');

  /*static Stream<Map> get dataStream => DB.stream('groups').map((event) {
        event.removeWhere((key, value) => !User.fromMap(FA.userId, _users[FA.userId]).groups.contains(key));
        return event;
      }).distinct((p, n) => mapEquals(p, n));*/

  static Future<void> setup() async {
    var users = await DB.read('users');
    _users = users is Map ? users : {};

    User me = User.fromMap(FA.userId);

    usersStream.listen((event) => _users = Log.print(event, prefix: 'Users'));

    for (String element in me.groups) {
      DB.stream(element).listen((event) {});
    }

    //dataStream.listen((event) => Log.print(event, prefix: 'Groups'));

    /*usersStream().listen((value) {
      _users = Tools.print(value is Map ? value : {}, prefix: 'Users');
    });

    groupsStream().listen((value) {
      _groups = Tools.print(value is Map ? value : {}, prefix: 'Groups');
    });

    listsStream('').listen((value) {
      _lists = Tools.print(value is Map ? value : {}, prefix: 'Lists');
    });

    productsStream('').listen((value) {
      _products = Tools.print(value is Map ? value : {}, prefix: 'Products');
    });*/
  }

  //static User getUser(String userId) => User.fromMap(userId, _users[userId] ?? {});
  //static Group getGroup(String groupId) => Group.fromMap(groupId, _groups[groupId] ?? {});
  //static GroupList getList(Group group, String listId) => GroupList.fromMap(listId, _lists[listId] ?? {});
}

class User {
  final String id;
  final String name;
  final List groups;

  User({required this.id, required this.name, required this.groups});

  factory User.fromMap(String id) {
    return User(
      id: id,
      name: '',
      groups: Tools.loadList(Data._users, '$id/groups', []),
    );
  }
}

class Group {
  final String id;
  final String name;
  final List<GroupList> lists;

  Group({required this.id, required this.name, required this.lists});

  factory Group.fromMap(String id, Map group) {
    return Group(
      id: id,
      name: group['name'],
      lists: [],
    );
  }
}

class GroupList {
  final String id;
  final String name;
  final List<ListProduct> products;

  GroupList({required this.id, required this.name, required this.products});

  //factory GroupList.fromMap(String id, Map list) {}
}

class ListProduct {}
