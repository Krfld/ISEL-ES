import 'package:cloud_firestore/cloud_firestore.dart';

import './firebase.dart';
import './../imports.dart';

class Data {
  static Group? currentGroup;
  static ShoppingList? currentList;

  static Stream<List<Group>> getGroups() => FirebaseFirestore.instance
      .collection('groups')
      .where('users', arrayContains: FA.user.id)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Group.fromMap(doc.id, doc.data())).toList()..sort());

  static Stream<List<ShoppingList>> getLists() => FirebaseFirestore.instance
      .collection('groups')
      .doc(currentGroup!.id)
      .collection('lists')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => ShoppingList.fromMap(doc.id, doc.data())).toList()..sort());
}
