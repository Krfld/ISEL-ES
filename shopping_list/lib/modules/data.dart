import 'package:async/async.dart' show StreamGroup;
import 'package:cloud_firestore/cloud_firestore.dart';

import './firebase.dart';
import './../imports.dart';

class Data {
  static AppUser get user => FA.user;

  static Group? currentGroup;
  static ShoppingList? currentList;

  static Future<void> createGroup(String groupName) async {
    await CF.addDocument('groups', {
      'name': groupName,
      'users': [user.id],
    });
  }

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

  static Stream<List<Group>> getGroups() => CF.firestoreInstance
      .collection('groups')
      .where('users', arrayContains: FA.user.id)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Group.fromMap(doc.id, doc.data())).toList()..sort());

  static Stream<List<ShoppingList>> getLists() => StreamGroup.merge([
        CF.firestoreInstance
            .collection('groups')
            .doc(currentGroup!.id)
            .collection('lists')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((doc) => ShoppingList.fromMap(doc.id, doc.data())).toList()..sort()),
      ]);
}
