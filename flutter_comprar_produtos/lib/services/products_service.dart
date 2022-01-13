import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/product.dart';
import '../entities/signature.dart';
import '../repositories/products_repository.dart';

class ProductsService {
  static final ProductsRepository _productsRepository = ProductsRepositoryCloudFirestore();

  static List<Product> products = [];

  static Product getProduct(String productId) => products.singleWhere((product) => product.id == productId);

  /// Operations

  void buyProduct(Product product) {
    product.bought = Signature(user: 'user', timestamp: DateTime.now().millisecondsSinceEpoch);
    _productsRepository.updateProduct('g1', 'l1', product);
  }

  /// Streams

  static Stream<List<Product>> get productsStream => _productsRepository.productsStream('g1', 'l1');

  static final StreamController<void> _customProductsStreamController = StreamController.broadcast();
  static void sinkCustomProductsStream() => _customProductsStreamController.sink.add(null);
  static Stream<void> get customProductsStream => _customProductsStreamController.stream;
}
