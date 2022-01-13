import 'dart:async';
import '../entities/product.dart';
import '../entities/signature.dart';
import '../repositories/products_repository.dart';

class ProductsService {
  static final ProductsRepository _productsRepository = ProductsRepositoryTest();

  static List<Product> products = [];

  static Product getProduct(String productId) => products.singleWhere((product) => product.id == productId);

  /// Operations

  static Future<bool> buyProduct(Product product) async {
    product.bought = Signature(user: 'u1', timestamp: DateTime.now().millisecondsSinceEpoch);
    return _productsRepository.updateProduct(product);
  }

  static Future<bool> unbuyProduct(Product product) async {
    product.bought = null;
    return _productsRepository.updateProduct(product);
  }

  /// Streams

  static Stream<List<Product>> get productsStream => _productsRepository.productsStream('g1', 'l1');

  // Esta stream serve para indicar quando um produto foi atualizado às várias vistas que precisam dessa informação sem ter de fazer get à base de dados
  static Stream<void> get customProductsStream => _customProductsStreamController.stream;
  static final StreamController<void> _customProductsStreamController = StreamController.broadcast();
  static void sinkCustomProductsStream() => _customProductsStreamController.sink.add(null);
}
