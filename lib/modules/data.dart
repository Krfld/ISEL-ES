import 'package:flutter/foundation.dart';
export '../modules/firebase.dart';

import '../.imports.dart';

class Data {
  static Map _users = {};
  static Map _data = {};

  static Map<String, Stream<Map>> _groupStreams = {};

  static String? _currentGroup; // Try Group
  static String? _currentList; // Try GroupList

  static Stream<Map> usersStream() => DB.stream('users');
  static Stream<Map> groupsStream(String groupId) => Tools.load(_groupStreams, groupId);

  static Future<void> setup() async {
    if (_users.isNotEmpty) return;

    var users = await DB.read('users');
    _users = users is Map ? users : {};

    User user = User.getUser(FA.userId);

    usersStream().listen((event) => _users = Log.print(event, prefix: 'Users'));

    for (String groupId in user.groups) _groupStreams.addAll({groupId: DB.stream('groups/$groupId')});

    for (String groupId in user.groups)
      groupsStream(groupId).listen((event) => _data.update(groupId, (value) => event, ifAbsent: () => event));
  }

  static User getUser(String userId) => User.getUser(userId);
  static Group getGroup(String groupId) => Group.getGroupFromMap(groupId, _data);
  static GroupList getGroupList(String groupId, String listId) => Tools.load(getGroup(groupId).lists, 'listId');
  static ListProduct getListProduct(String groupId, String listId, String productId) =>
      Tools.load(getGroupList(groupId, listId).products, 'productId');

  static List<User> getUsers() => List.generate(
        _users.keys.length,
        (index) => getUser(_users.keys.elementAt(index)),
        growable: false,
      );
  static List<Group> getGroups() => List.generate(
        _data.keys.length,
        (index) => getGroup(_data.keys.elementAt(index)),
        growable: false,
      );
  static List<GroupList> getGroupLists(String groupId) => List.generate(
        getGroup(groupId).lists.keys.length,
        (index) => getGroup(groupId).lists.values.elementAt(index),
        growable: false,
      );
  static List<ListProduct> getListProducts(String groupId, String listId) => List.generate(
        getGroupList(groupId, listId).products.keys.length,
        (index) => getGroupList(groupId, listId).products.values.elementAt(index),
        growable: false,
      );
}

class User {
  final String id;
  final String name;
  final List groups;

  User({
    required this.id,
    required this.name,
    required this.groups,
  });

  User.empty()
      : this(
          id: '',
          name: '',
          groups: [],
        );

  factory User.getUser(String userId) {
    return User(
      id: userId,
      name: '',
      groups: Tools.loadList(Data._users, '$userId/groups', []),
    );
  }
}

class Group {
  final String id;
  final String name;
  final Map<String, GroupList> lists;

  Group({
    required this.id,
    required this.name,
    required this.lists,
  });

  Group.empty()
      : this(
          id: '',
          name: '',
          lists: {},
        );

  factory Group.getGroupFromMap(String groupId, Map groups) {
    Map<String, GroupList> groupLists = {};
    Map lists = Tools.loadMap(groups, '$groupId/lists', {});

    for (var listId in lists.keys) groupLists.addAll({listId: GroupList.getGroupListFromMap(groupId, listId, lists)});

    return Group(
      id: groupId,
      name: Tools.loadString(groups, '$groupId/name', ''),
      lists: groupLists,
    );
  }
}

class GroupList {
  final String id;
  final String name;
  final Map<String, ListProduct> products;

  GroupList({
    required this.id,
    required this.name,
    required this.products,
  });

  GroupList.empty()
      : this(
          id: '',
          name: '',
          products: {},
        );

  factory GroupList.getGroupListFromMap(String groupId, String listId, Map lists) {
    Map<String, ListProduct> listProducts = {};
    Map products = Tools.loadMap(lists, '$listId/products', {});

    for (var productId in products.keys)
      listProducts.addAll({productId: ListProduct.fromMap(groupId, listId, productId, products)});

    return GroupList(
      id: listId,
      name: Tools.loadString(lists, '$listId/name', ''),
      products: listProducts,
    );
  }
}

class ListProduct {
  final String id;
  final String name;
  final DateTime added;
  final String brand;
  final String details;
  final int amount;
  final bool flag;

  ListProduct({
    required this.id,
    required this.name,
    required this.added,
    required this.brand,
    required this.details,
    required this.amount,
    required this.flag,
  });

  ListProduct.empty()
      : this(
          id: '',
          name: '',
          added: DateTime.fromMillisecondsSinceEpoch(0),
          brand: '',
          details: '',
          amount: 0,
          flag: false,
        );

  factory ListProduct.fromMap(String groupId, String listId, String productId, Map products) {
    return ListProduct(
      id: productId,
      name: Tools.loadString(products, '$productId/name', ''),
      added: DateTime.fromMillisecondsSinceEpoch(Tools.loadInt(products, '$productId/added', 0)),
      brand: Tools.loadString(products, '$productId/brand', ''),
      details: Tools.loadString(products, '$productId/details', ''),
      amount: Tools.loadInt(products, '$productId/amount', 1),
      flag: Tools.loadBool(products, '$productId/flag', false),
    );
  }
}
