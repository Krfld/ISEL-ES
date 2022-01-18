import 'dart:io';
import './services/products_service.dart';
import './entities/product.dart';
import './entities/signature.dart';

void main(List<String> arguments) {
  final TestBuyProducts testBuyProducts = TestBuyProducts();
  testBuyProducts.executar();
}

String readInput() => stdin.readLineSync() ?? '';

class TestBuyProducts {
  final List<Product> expectedProductsUserCanSee = [
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
  ];

  static final DateTime dateAdded = DateTime.utc(2021, 1, 1, 12).subtract(Duration(days: 2));
  static final DateTime currentTime = DateTime.utc(2021, 1, 1, 12);

  void executar() {
    print('Current time: $currentTime\n');

    ProductsService.productsStream.listen((event) => print('Produtos atuais na base de dados:\n$event\n'));

    ProductsService.productsStream.listen((event) {
      List<Product> productsUserSees = event
          .where((product) =>
              // Se foi comprado pelo próprio utilizador
              (product.bought?.user ?? 'u1') == 'u1' &&
              // Se foi comprado há menos de 24 horas
              (!(product.bought?.timestamp!.add(Duration(hours: 24)).difference(currentTime).isNegative ?? false)))
          .toList();

      print('Produtos que o utilizador devia ver:\n$expectedProductsUserCanSee\n');
      print('Produtos que o utilizador vê:\n$productsUserSees\n');
    });
  }
}
