import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:async/async.dart' show StreamGroup;

import './firebase.dart';
import './../imports.dart';

class Data {
  static AppUser get user => FA.user;

  static Group? currentGroup;
  static ShoppingList? currentList;

  static Stream<List<Group>> getGroups() => FirebaseFirestore.instance
      .collection('groups')
      .where('users', arrayContains: FA.user.id)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Group.fromMap(doc.id, doc.data())).toList()..sort());

  static Stream<List<ShoppingList>> getLists() => StreamGroup.merge([
        FirebaseFirestore.instance
            .collection('groups')
            .doc(currentGroup!.id)
            .collection('lists')
            .snapshots()
            .map((snapshot) => snapshot.docs.map((doc) => ShoppingList.fromMap(doc.id, doc.data())).toList()..sort()),
      ]);
}
