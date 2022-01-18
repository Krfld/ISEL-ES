import 'dart:async';
import '../entities/product.dart';
import '../entities/signature.dart';

abstract class ProductsRepository {
  Stream<List<Product>> productsStream(String currentGroupId, String currentListId);
  Future<bool> updateProduct(String currentGroupId, String currentListId, Product product);
}

class ProductsRepositoryTest implements ProductsRepository {
  static final DateTime dateAdded = DateTime.utc(2021, 1, 1, 12).subtract(Duration(days: 2));
  static final DateTime currentTime = DateTime.utc(2021, 1, 1, 12);

  final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'a',
      brand: null,
      store: null,
      details: null,
      amount: null,
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
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
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought: Signature(user: 'u1', timestamp: currentTime.subtract(Duration(hours: 1))),
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
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought: null,
      removed: null,
    ),
    Product(
      id: 'p4',
      name: 'd',
      brand: null,
      store: null,
      details: null,
      amount: null,
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought: Signature(user: 'u2', timestamp: currentTime.subtract(Duration(hours: 1))), // Comprado por outra pessoa
      removed: null,
    ),
    Product(
      id: 'p5',
      name: 'e',
      brand: null,
      store: null,
      details: null,
      amount: null,
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought:
          Signature(user: 'u1', timestamp: currentTime.subtract(Duration(hours: 25))), // Comprado há mais de 24 horas
      removed: null,
    ),
  ];

  @override
  Stream<List<Product>> productsStream(String currentGroupId, String currentListId) => Stream.value(_products);

  @override
  Future<bool> updateProduct(String currentGroupId, String currentListId, Product product) async {
    if (!_products.any((element) => element.id == product.id)) return false; // Check if product exists
    _products.removeWhere((element) => element.id == product.id); // Remove product
    _products.add(product); // Add product
    return true;
  }
}
