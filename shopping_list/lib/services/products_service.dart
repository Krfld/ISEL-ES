import 'dart:async';
import 'package:shopping_list/repositories/products_repository.dart';

import '../models/product.dart';

class ProductsModel {
  static List<Product> products = [];

  static Product getProduct(String productId) => products.singleWhere((product) => product.id == productId);

  /// Repository

  /// Streams

  static Stream<List<Product>> get firestoreProductsStream => ProductsRepository.firestoreProductsStream
      .map((snapshot) => snapshot.docs.map((doc) => Product.fromMap(doc.id, doc.data())).toList()..sort());

  static final StreamController<void> _productsStreamController = StreamController.broadcast();
  static void sinkProductsStream() => _productsStreamController.sink.add(null);
  static Stream<void> get productsStream => _productsStreamController.stream;
}
