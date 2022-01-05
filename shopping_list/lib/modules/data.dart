import 'dart:async';

import 'package:async/async.dart' show StreamGroup;
import 'package:cloud_firestore/cloud_firestore.dart';

import './firebase.dart';
import './../imports.dart';

class Data {
  static AppUser get user => FA.user;

  // Groups
  static List<Group> groups = [];

  static final StreamController<void> _groupsStreamController = StreamController.broadcast();
  static void sinkGroupsStream() => _groupsStreamController.sink.add(null);
  static Stream<void> get groupsStream => _groupsStreamController.stream;

  static String? _currentGroupId;
  static Group getGroup(String groupId) => groups.singleWhere((group) => group.id == groupId);
  static Group get currentGroup => getGroup(_currentGroupId!);
  static set currentGroup(Group? group) => _currentGroupId = group?.id;

  // Lists
  static List<ShoppingList> lists = [];

  static final StreamController<void> _listsStreamController = StreamController.broadcast();
  static void sinkListsStream() => _listsStreamController.sink.add(null);
  static Stream<void> get listsStream => _listsStreamController.stream;

  static String? _currentListId;
  static ShoppingList get currentList => lists.singleWhere((list) => list.id == _currentListId);
  static set currentList(ShoppingList? list) => _currentListId = list?.id;

  // Products
  static List<Product> products = [];

  // ----------------------------------------------------------------------------------------------------

  static Stream<List<Group>> get firestoreGroupsStream => CF.firestoreInstance
      .collection('groups')
      .where('users', arrayContains: user.id)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Group.fromMap(doc.id, doc.data())).toList()..sort());

  static Future<void> createGroup(String groupName) async => await CF.addDocument('groups', {
        'name': groupName,
        'users': [user.id],
      });

  static Future<bool> joinGroup(String groupId) async {
    try {
      await CF.firestoreInstance.collection('groups').doc(groupId).update({
        'users': FieldValue.arrayUnion([user.id]),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateGroup(String groupId, String groupName) async {
    try {
      await CF.firestoreInstance.collection('groups').doc(groupId).update({
        'name': groupName,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // ----------------------------------------------------------------------------------------------------

  static Stream<List<ShoppingList>> get firestoreListsStream => CF.firestoreInstance
      .collection('groups')
      .doc(currentGroup.id)
      .collection('lists')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => ShoppingList.fromMap(doc.id, doc.data())).toList()..sort());

  static Future<void> createList(String listName) async => await CF.addDocument('groups/${currentGroup.id}/lists', {
        'name': listName,
      });
}
