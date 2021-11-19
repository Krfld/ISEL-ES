import 'dart:async';

import 'package:async/async.dart';
import '../modules/firebase.dart';

import '../.imports.dart';

class Data {
  static Map users = {};
  static final Map data = {};

  static Map<String, Stream<Map>> _streams = {};
  static Map<String, StreamSubscription<Map>> _streamSubscriptions = {};

  static Stream<Map> usersStream() => DB.stream('users');
  static Stream<Map> groupStream(String groupId) => Tools.load(_streams, groupId);
  static Stream<Map> dataStream() => StreamGroup.merge(_streams.values);

  static void refreshStreams() {
    User user = User.fromId(FA.userId);

    _streams.clear();
    for (StreamSubscription streamSubscription in _streamSubscriptions.values) streamSubscription.cancel();
    _streamSubscriptions.clear();

    for (String groupId in user.groups) _streams.addAll({groupId: DB.stream('groups/$groupId')});

    for (String groupId in user.groups)
      _streamSubscriptions.addAll({
        groupId: groupStream(groupId).listen(
            (event) => Log.print(data.update(groupId, (value) => event, ifAbsent: () => event), prefix: groupId))
      });
  }

  static Group? currentGroup;
  static GroupList? currentList;

  ///
  ///
  ///

  static Future<void> init() async {
    var usersMap = await DB.read('users');
    users = usersMap is Map ? usersMap : {};

    usersStream().listen((event) => Log.print(users = event, prefix: 'Users'));

    refreshStreams();
  }

  /// Classes

  static User getUser(String userId) => User.fromId(userId);

  static Group getGroup(String groupId) => Group.fromId(groupId);

  static GroupList getGroupList(String groupId, String listId) => GroupList.fromId(groupId, listId);

  static Product getListProduct(String groupId, String listId, String productId) =>
      Product.fromId(groupId, listId, productId);

  /// Lists

  static List<User> getUsers() => List.generate(
        users.keys.length,
        (index) => getUser(users.keys.elementAt(index)),
      );

  static List<Group> getGroups() => List.generate(
        data.keys.length,
        (index) => getGroup(data.keys.elementAt(index)),
      );

  static List<GroupList> getGroupLists(Group group) => List.generate(
        group.lists.length,
        (index) => getGroupList(group.id, group.lists.elementAt(index)),
      );

  static List<Product> getListProducts(Group group, GroupList list) => List.generate(
        list.products.length,
        (index) => getListProduct(group.id, list.id, list.products.elementAt(index)),
      );
}
