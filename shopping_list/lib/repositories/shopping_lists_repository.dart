import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/firebase.dart';

class ShoppingListsRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> firestoreListsStream(String groupId) =>
      CF.firestoreInstance.collection('groups').doc(groupId).collection('lists').snapshots();

  Future<void> createList(String groupId, String listName) async => await CF.addDocument('groups/$groupId/lists', {
        'name': listName,
      });

  Future<bool> updateList(String groupId, String listId, String listName) async =>
      await CF.updateDocument('groups/$groupId/lists/$listId', {
        'name': listName,
      });
}
