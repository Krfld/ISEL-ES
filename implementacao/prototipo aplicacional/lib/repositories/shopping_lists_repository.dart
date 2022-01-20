import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/shopping_list.dart';

abstract class ShoppingListsRepository {
  Stream<List<ShoppingList>> listsStream(String groupId);
}

class ShoppingListsRepositoryCloudFirestore implements ShoppingListsRepository {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  @override
  Stream<List<ShoppingList>> listsStream(String groupId) => _instance
      .collection('test_groups')
      .doc(groupId)
      .collection('test_lists')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => ShoppingList.fromMap(doc.id, doc.data())).toList()..sort());
}
