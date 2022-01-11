import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/firebase.dart';

import '../entities/shopping_list.dart';

class ShoppingListsRepository {
  Stream<List<ShoppingList>> listsStream(String groupId) => CF.firestoreInstance
      .collection('groups')
      .doc(groupId)
      .collection('lists')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => ShoppingList.fromMap(doc.id, doc.data())).toList()..sort());

  Future<void> createList(String groupId, String listName) async => await CF.addDocument('groups/$groupId/lists', {
        'name': listName,
      });

  Future<bool> updateList(String groupId, String listId, String listName) async =>
      await CF.updateDocument('groups/$groupId/lists/$listId', {
        'name': listName,
      });
}
