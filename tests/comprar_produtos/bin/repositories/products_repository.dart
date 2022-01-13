import 'dart:async';
import 'dart:math';
import '../entities/product.dart';
import '../entities/signature.dart';

abstract class ProductsRepository {
  Stream<List<Product>> productsStream(String currentGroupId, String currentListId);
  Future<void> addProduct(Product product);
  Future<bool> updateProduct(Product product);
}

class ProductsRepositoryTest implements ProductsRepository {
  final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'a',
      brand: null,
      store: null,
      details: null,
      amount: null,
      tag: 0,
      added: Signature(user: 'u1', timestamp: 0),
      bought: null,
      removed: null,
    ),
    Product(
      id: 'p2',
      name: 'b',
      brand: null,
      store: null,
      details: null,
      amount: null,
      tag: 0,
      added: Signature(user: 'u1', timestamp: 1),
      bought: null,
      removed: null,
    ),
    Product(
      id: 'p3',
      name: 'c',
      brand: null,
      store: null,
      details: null,
      amount: null,
      tag: 0,
      added: Signature(user: 'u1', timestamp: 2),
      bought: null,
      removed: null,
    ),
  ];

  final StreamController<void> _productsStreamController = StreamController.broadcast();

  ProductsRepositoryTest() {
    _productsStreamController.sink.add(null);
  }

  @override
  Stream<List<Product>> productsStream(String currentGroupId, String currentListId) =>
      _productsStreamController.stream.map((_) => _products..sort());

  @override
  Future<void> addProduct(Product product) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateProduct(Product product) async {
    if (!_products.any((element) => element.id == product.id)) return false; // Check if product exists
    _products.removeWhere((element) => element.id == product.id); // Remove product
    _products.add(product); // Add product
    _productsStreamController.sink.add(null);
    return true;
  }
}
