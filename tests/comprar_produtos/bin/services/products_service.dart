import 'dart:async';

import '../entities/product.dart';
import '../entities/signature.dart';
import '../repositories/products_repository.dart';

class ProductsService {
  static final ProductsRepository _productsRepository = ProductsRepositoryTest();

  // Lista de produtos que está sempre atualizada
  static List<Product> products = [];

  // Obter um produto da lista de produtos que está sempre atualizada
  static Product getProduct(String productId) => products.singleWhere((product) => product.id == productId);

  /// Operations

  static Future<bool> buyProduct(Product product) async {
    product.bought = Signature(user: 'u1');
    return _productsRepository.updateProduct('g1', 'l1', product);
  }

  static Future<bool> unbuyProduct(Product product) async {
    product.bought = null;
    return _productsRepository.updateProduct('g1', 'l1', product);
  }

  /// Streams

  // Stream dos produtos que atualiza a lista de produtos sempre que houver uma alteração
  static Stream<List<Product>> get productsStream => _productsRepository.productsStream('g1', 'l1');
  static Stream<List<Product>> get buyingProductsStream => productsStream.map((event) {
        final DateTime currentTime = DateTime.utc(2021, 1, 1, 12); // For testing
        return event
            .where((product) =>
                // Se foi comprado pelo próprio utilizador
                (product.bought?.user ?? 'u1') == 'u1' &&
                // Se foi comprado há menos de 24 horas
                (!(product.bought?.timestamp!.add(Duration(hours: 24)).difference(currentTime).isNegative ?? false)))
            .toList();
      });

  // Stream para atualizar as vistas sempre que houver uma alteração
  static final StreamController<void> _customProductsStreamController = StreamController.broadcast();
  static void sinkCustomProductsStream() => _customProductsStreamController.sink.add(null);
  static Stream<void> get customProductsStream => _customProductsStreamController.stream;
}
