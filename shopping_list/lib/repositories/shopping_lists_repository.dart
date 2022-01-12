import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/firebase.dart';

import '../entities/shopping_list.dart';

abstract class ShoppingListsRepository {
  Stream<List<ShoppingList>> listsStream(String groupId);
  Future<void> createList(String groupId, String listName);
  Future<bool> updateList(String groupId, String listId, String listName);
}

class ShoppingListsRepositoryCloudFirestore implements ShoppingListsRepository {
  @override
  Stream<List<ShoppingList>> listsStream(String groupId) => CF.firestoreInstance
      .collection('groups')
      .doc(groupId)
      .collection('lists')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => ShoppingList.fromMap(doc.id, doc.data())).toList()..sort());

  @override
  Future<void> createList(String groupId, String listName) async => await CF.addDocument('groups/$groupId/lists', {
        'name': listName,
      });

  @override
  Future<bool> updateList(String groupId, String listId, String listName) async =>
      await CF.updateDocument('groups/$groupId/lists/$listId', {
        'name': listName,
      });
}
