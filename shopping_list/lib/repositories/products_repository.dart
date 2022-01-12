import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/firebase.dart';

import '../entities/product.dart';

abstract class ProductsRepository {
  Stream<List<Product>> productsStream(String currentGroupId, String currentListId);
}

class ProductsRepositoryCloudFirestore implements ProductsRepository {
  @override
  Stream<List<Product>> productsStream(String currentGroupId, String currentListId) => CF.firestoreInstance
      .collection('groups')
      .doc(currentGroupId)
      .collection('lists')
      .doc(currentListId)
      .collection('products')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Product.fromMap(doc.id, doc.data())).toList()..sort());
}
