import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/firebase.dart';

import '../services/groups_service.dart';
import '../services/lists_service.dart';

class ProductsRepository {
  static Stream<QuerySnapshot<Map<String, dynamic>>> get firestoreProductsStream => CF.firestoreInstance
      .collection('groups')
      .doc(GroupsService.currentGroup.id)
      .collection('lists')
      .doc(ShoppingListsService.currentList.id)
      .collection('products')
      .snapshots();
}
