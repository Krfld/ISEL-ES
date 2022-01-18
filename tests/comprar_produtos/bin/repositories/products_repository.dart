import 'dart:async';
import '../entities/product.dart';
import '../entities/signature.dart';

abstract class ProductsRepository {
  Stream<List<Product>> productsStream(String currentGroupId, String currentListId);
  Future<bool> updateProduct(String currentGroupId, String currentListId, Product product);
}

class ProductsRepositoryTest implements ProductsRepository {
  static final DateTime currentTime = DateTime.utc(2021, 6, 15, 13);
  static final DateTime dateAdded = currentTime.subtract(Duration(days: 2));

  final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'a',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
    ),
    Product(
      id: 'p2',
      name: 'b',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought: Signature(user: 'u1', timestamp: currentTime.subtract(Duration(hours: 2))),
    ),
    Product(
      id: 'p3',
      name: 'c',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought: Signature(user: 'u2', timestamp: currentTime.subtract(Duration(hours: 2))), // Comprado por outra pessoa
    ),
    Product(
      id: 'p4',
      name: 'd',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought:
          Signature(user: 'u1', timestamp: currentTime.subtract(Duration(hours: 25))), // Comprado há mais de 24 horas
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
