import 'dart:async';

import '../.imports.dart';

class Data {
  static Map _users = {};
  static Map _groups = {};
  static Map _lists = {};
  static Map _products = {};

  static String? currentGroup;
  static String? currentList;

  static Stream usersStream() => DB.stream('users').map((event) => event.snapshot.value);
  static Stream groupsStream() => DB.stream('groups').map((event) => event.snapshot.value).distinct((p, n) {
        Tools.print(p);
        Tools.print(n);
        return true;
      }); // ! Testing
  static Stream listsStream(String groupId) => DB.stream('groups/$groupId/lists').map((event) => event.snapshot.value);
  static Stream productsStream(String groupId, String listId) =>
      DB.stream('groups/$groupId/lists/$listId/products').map((event) => event.snapshot.value);

  static void setup() {
    groupsStream().listen((event) {
      Tools.print(event);
    });
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

  static User getUser(String userId) => User.fromMap(userId, _users[userId] ?? {});
  static Group getGroup(String groupId) => Group.fromMap(groupId, _groups[groupId] ?? {});
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
