import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/firebase.dart';

import '../entities/product.dart';

class ProductsRepository {
  static Stream<List<Product>> productsStream(String groupId, String listId) => CF.firestoreInstance
      .collection('groups')
      .doc(groupId)
      .collection('lists')
      .doc(listId)
      .collection('products')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Product.fromMap(doc.id, doc.data())).toList()..sort());
}
