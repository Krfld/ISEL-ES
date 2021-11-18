export '../modules/firebase.dart';

import '../.imports.dart';

class Data {
  static Map _users = {};
  static Map _data = {};

  static Map<String, Stream<Map>> _groupStreams = {};

  static Group? currentGroup; // Try Group
  static GroupList? currentList; // Try GroupList

  static Stream<Map> usersStream() => DB.stream('users');
  static Stream<Map> groupsStream(String groupId) => Tools.load(_groupStreams, groupId);

  ///
  ///
  ///

  static Future<void> setup() async {
    if (_users.isNotEmpty) return;

    var users = await DB.read('users');
    _users = users is Map ? users : {};

    User user = User._getUser(FA.userId);

    usersStream().listen((event) => _users = event);

    for (String groupId in user.groups) _groupStreams.addAll({groupId: DB.stream('groups/$groupId')});

    for (String groupId in user.groups)
      groupsStream(groupId).listen((event) => _data.update(groupId, (value) => event, ifAbsent: () => event));
  }

  ///
  ///
  ///

  /// Objects

  static User getUser(String userId) => User._getUser(userId);

  static Group getGroup(String groupId) => Group._fromId(groupId);

  static GroupList getGroupList(String groupId, String listId) => GroupList._fromId(groupId, listId);

  static ListProduct getListProduct(String groupId, String listId, String productId) =>
      ListProduct._fromId(groupId, listId, productId);

  /// Lists

  static List<User> getUsers() => List.generate(
        _users.keys.length,
        (index) => getUser(_users.keys.elementAt(index)),
      );

  static List<Group> getGroups() => List.generate(
        _data.keys.length,
        (index) => getGroup(_data.keys.elementAt(index)),
      );

  static List<GroupList> getGroupLists(Group group) => List.generate(
        group.lists.length,
        (index) => getGroupList(group.id, group.lists.elementAt(index)),
      );

  static List<ListProduct> getListProducts(Group group, GroupList list) => List.generate(
        list.products.length,
        (index) => getListProduct(group.id, list.id, list.products.elementAt(index)),
      );
}

///
///
///

class User {
  final String id;
  final String name;
  final List groups;

  User({
    required this.id,
    required this.name,
    required this.groups,
  });

  factory User._getUser(String userId) {
    return User(
      id: userId,
      name: '',
      groups: Tools.loadList(Data._users, '$userId/groups', []),
    );
  }
}

///
///
///

class Group {
  final String id;
  final String name;
  final List lists;

  Group({
    required this.id,
    required this.name,
    required this.lists,
  });

  factory Group._fromId(String groupId) {
    Map group = Tools.load(Data._data, groupId);

    Iterable lists = Tools.loadMap(group, 'lists', {}).keys;
    List groupLists = List.generate(lists.length, (index) => lists.elementAt(index));

    return Group(
      id: groupId,
      name: Tools.loadString(group, 'name', ''),
      lists: groupLists,
    );
  }
}

///
///
///

class GroupList {
  final String id;
  final String name;
  final List products;

  GroupList({
    required this.id,
    required this.name,
    required this.products,
  });

  factory GroupList._fromId(String groupId, String listId) {
    Map list = Tools.loadMap(Data._data, '$groupId/lists/$listId', {});

    Iterable products = Tools.loadMap(list, 'products', {}).keys;
    List listProducts = List.generate(products.length, (index) => products.elementAt(index));

    return GroupList(
      id: listId,
      name: Tools.loadString(list, 'name', ''),
      products: listProducts,
    );
  }
}

///
///
///

class ListProduct {
  final String id;
  final String name;
  final DateTime added;
  final String? brand;
  final String? store;
  final String? info;
  final int? amount;
  final bool flag;

  ListProduct({
    required this.id,
    required this.name,
    required this.added,
    required this.brand,
    required this.store,
    required this.info,
    required this.amount,
    required this.flag,
  });

  factory ListProduct._fromId(String groupId, String listId, String productId) {
    Map product = Tools.loadMap(Data._data, '$groupId/lists/$listId/products/$productId', {});

    return ListProduct(
      id: productId,
      name: Tools.loadString(product, 'name', ''),
      added: DateTime.fromMillisecondsSinceEpoch(Tools.loadInt(product, 'added', 0)),
      brand: Tools.load(product, 'brand'),
      store: Tools.load(product, 'store'),
      info: Tools.load(product, 'info'),
      amount: Tools.load(product, 'amount'),
      flag: Tools.loadBool(product, 'flag', false),
    );
  }
}
