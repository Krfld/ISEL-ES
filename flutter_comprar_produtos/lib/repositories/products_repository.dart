import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/product.dart';

abstract class ProductsRepository {
  Stream<List<Product>> productsStream(String currentGroupId, String currentListId);
  Future<bool> updateProduct(String currentGroupId, String currentListId, Product product);
}

class ProductsRepositoryCloudFirestore implements ProductsRepository {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  @override
  Stream<List<Product>> productsStream(String currentGroupId, String currentListId) => _instance
      .collection('groups')
      .doc(currentGroupId)
      .collection('lists')
      .doc(currentListId)
      .collection('products')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Product.fromMap(doc.id, doc.data())).toList()..sort());

  @override
  Future<bool> updateProduct(String currentGroupId, String currentListId, Product product) async {
    try {
      _instance
          .collection('groups')
          .doc(currentGroupId)
          .collection('lists')
          .doc(currentListId)
          .collection('products')
          .doc(product.id)
          .update(product.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
