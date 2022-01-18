import './services/products_service.dart';
import './entities/product.dart';
import './entities/signature.dart';

void main(List<String> arguments) {
  final TestBuyProducts testBuyProducts = TestBuyProducts();
  testBuyProducts.executar();
}

class TestBuyProducts {
  final List<Product> expectedBuyingProducts = [
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
  ];

  final List<Product> expectedBuyingProductsAfterBuyingP1 = [
    Product(
      id: 'p1',
      name: 'a',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought: Signature(user: 'u1', timestamp: currentTime),
    ),
    Product(
      id: 'p2',
      name: 'b',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought: Signature(user: 'u1', timestamp: currentTime.subtract(Duration(hours: 2))),
    ),
  ];

  final List<Product> expectedBuyingProductsAfterUnbuyingP2 = [
    Product(
      id: 'p1',
      name: 'a',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
      bought: Signature(user: 'u1', timestamp: currentTime),
    ),
    Product(
      id: 'p2',
      name: 'b',
      tag: 0,
      added: Signature(user: 'u1', timestamp: dateAdded),
    ),
  ];

  static final DateTime currentTime = DateTime.utc(2021, 6, 15, 13); // For testing
  static final DateTime dateAdded = currentTime.subtract(Duration(days: 2)); // For testing

  void executar() async {
    // Assumir um tempo atual
    print('Current time: $currentTime\n');

    // Atualizar a lista de produtos
    await ProductsService.productsStream.listen((event) => ProductsService.products = event).asFuture();
    // await garante ter terminado a receção da base de dados de teste e atualização dos produtos

    // Produtos lidos
    print('Produtos atuais na base de dados:\n${ProductsService.products}\n');

    // Produtos que o utilizador devia ver
    print('Produtos que o utilizador devia ver:\n$expectedBuyingProducts\n');
    // Produtos que o utilizador vê
    print('Produtos que o utilizador vê:\n${ProductsService.buyingProducts}\n');

    // --------------------------------------------------

    ProductsService.buyProduct(ProductsService.getProduct('p1'));

    // Atualizar a lista de produtos
    await ProductsService.productsStream.listen((event) => ProductsService.products = event).asFuture();

    print('Produtos que o utilizador devia ver após comprar p1:\n$expectedBuyingProductsAfterBuyingP1\n');

    print('Produtos que o utilizador vê após comprar p1:\n${ProductsService.buyingProducts}\n');

    // --------------------------------------------------

    ProductsService.unbuyProduct(ProductsService.getProduct('p2'));

    // Atualizar a lista de produtos
    await ProductsService.productsStream.listen((event) => ProductsService.products = event).asFuture();

    print(
        'Produtos que o utilizador devia ver após cancelar a compra de p2:\n$expectedBuyingProductsAfterUnbuyingP2\n');

    print('Produtos que o utilizador vê após cancelar a compra de p2:\n${ProductsService.buyingProducts}\n');
  }
}
