import 'package:flutter/foundation.dart';

import '../.imports.dart';

class Data {
  static Map _users = {};
  static Map _data = {};

  static String? currentGroup;
  static String? currentList;

  static Stream<Map> usersStream() => DB.stream('users');

  static Stream<Map> groupsStream() => DB.stream('groups').map((event) {
        event.removeWhere((key, value) => !['a', 'c'].contains(key));
        return event;
      }).distinct((p, n) => mapEquals(p, n));

  static void setup() {
    groupsStream().listen((event) => Log.print(event.toString(), prefix: 'groups'));
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
  final List<String> groups;

  User({required this.id, required this.name, required this.groups});

  factory User.fromMap(String id, Map user) {
    return User(
      id: id,
      name: user['name'],
      groups: user['groups'],
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
