import 'dart:async';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

import '../services/groups_service.dart';
import '../services/shopping_lists_service.dart';

class ProductsService {
  static final ProductsRepository _productsRepository = ProductsRepositoryCloudFirestore();

  static List<Product> products = [];

  static Product getProduct(String productId) => products.singleWhere((product) => product.id == productId);

  /// Operations

  /// Streams

  static Stream<List<Product>> get productsStream =>
      _productsRepository.productsStream(GroupsService.currentGroup.id, ShoppingListsService.currentShoppingList.id);

  static final StreamController<void> _customProductsStreamController = StreamController.broadcast();
  static void sinkCustomProductsStream() => _customProductsStreamController.sink.add(null);
  static Stream<void> get customProductsStream => _customProductsStreamController.stream;
}
