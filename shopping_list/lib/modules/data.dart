import 'dart:async';
import 'package:async/async.dart' show StreamGroup;
import 'package:cloud_firestore/cloud_firestore.dart';

import './firebase.dart';
import './../imports.dart';

class GroupsLogic {
  static List<Group> groups = [];

  static String? _currentGroupId;
  static Group get currentGroup => getGroup(_currentGroupId!);
  static set currentGroup(Group? group) => _currentGroupId = group?.id;

  static Group getGroup(String groupId) => groups.singleWhere((group) => group.id == groupId);

  /// Streams
  static final StreamController<void> _groupsStreamController = StreamController.broadcast();
  static void sinkGroupsStream() => _groupsStreamController.sink.add(null);
  static Stream<void> get groupsStream => _groupsStreamController.stream;

  /// Database
  static Stream<List<Group>> get firestoreGroupsStream => DB.firestoreInstance
      .collection('groups')
      .where('users', arrayContains: FA.user.id)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Group.fromMap(doc.id, doc.data())).toList()..sort());

  static Future<void> createGroup(String groupName) async => await DB.addDocument('groups', {
        'name': groupName,
        'users': [FA.user.id],
      });

  static Future<bool> joinGroup(String groupId) async => await DB.updateDocument('groups/$groupId', {
        'users': FieldValue.arrayUnion([FA.user.id]),
      });

  static Future<bool> updateGroup(String groupId, String groupName) async =>
      await DB.updateDocument('groups/$groupId', {
        'name': groupName,
      });
}

class Data {
  static AppUser get user => FA.user;

  /// ShoppingLists
  static List<ShoppingList> lists = [];
  static String? _currentListId;
  static ShoppingList getList(String listId) => lists.singleWhere((list) => list.id == listId);

  static ShoppingList get currentList => getList(_currentListId!);
  static set currentList(ShoppingList? list) => _currentListId = list?.id;

  /// ShoppingLists streams
  static final StreamController<void> _listsStreamController = StreamController.broadcast();
  static void sinkListsStream() => _listsStreamController.sink.add(null);
  static Stream<void> get listsStream => _listsStreamController.stream;

  /// Products
  static List<Product> products = [];
  static Product getProduct(String productId) => products.singleWhere((product) => product.id == productId);

  /// Products streams
  static final StreamController<void> _productsStreamController = StreamController.broadcast();
  static void sinkProductsStream() => _productsStreamController.sink.add(null);
  static Stream<void> get productsStream => _productsStreamController.stream;

  /// ----------------------------------------------------------------------------------------------------

  /// ----------------------------------------------------------------------------------------------------

  static Stream<List<ShoppingList>> get firestoreListsStream => DB.firestoreInstance
      .collection('groups')
      .doc(GroupsLogic.currentGroup.id)
      .collection('lists')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => ShoppingList.fromMap(doc.id, doc.data())).toList()..sort());

  static Future<void> createList(String listName) async =>
      await DB.addDocument('groups/${GroupsLogic.currentGroup.id}/lists', {
        'name': listName,
      });

  /// ----------------------------------------------------------------------------------------------------

  static Stream<List<Product>> get firestoreProductsStream => DB.firestoreInstance
      .collection('groups')
      .doc(GroupsLogic.currentGroup.id)
      .collection('lists')
      .doc(currentList.id)
      .collection('products')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Product.fromMap(doc.id, doc.data())).toList()..sort());
}
