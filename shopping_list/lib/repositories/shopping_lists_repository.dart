import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/firebase.dart';

import '../services/groups_service.dart';

class ShoppingListsRepository {
  static Stream<QuerySnapshot<Map<String, dynamic>>> get firestoreListsStream =>
      CF.firestoreInstance.collection('groups').doc(GroupsService.currentGroup.id).collection('lists').snapshots();

  static Future<void> createList(String listName) async =>
      await CF.addDocument('groups/${GroupsService.currentGroup.id}/lists', {
        'name': listName,
      });

  static Future<bool> updatList(String listId, String listName) async =>
      await CF.updateDocument('groups/${GroupsService.currentGroup.id}/lists/$listId', {
        'name': listName,
      });
}
