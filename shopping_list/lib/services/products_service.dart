import 'dart:async';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

import '../services/groups_service.dart';
import '../services/shopping_lists_service.dart';

class ProductsModel {
  static List<Product> products = [];

  static Product getProduct(String productId) => products.singleWhere((product) => product.id == productId);

  /// Operations

  /// Streams

  static Stream<List<Product>> get firestoreProductsStream =>
      ProductsRepository.productsStream(GroupsService.currentGroup.id, ShoppingListsService.currentShoppingList.id);

  static final StreamController<void> _productsStreamController = StreamController.broadcast();
  static void sinkProductsStream() => _productsStreamController.sink.add(null);
  static Stream<void> get productsStream => _productsStreamController.stream;
}
