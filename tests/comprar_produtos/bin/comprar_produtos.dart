import 'dart:io';
import 'dart:math';
import './services/products_service.dart';
import './entities/product.dart';

String readInput() => stdin.readLineSync() ?? '';

class TestBuyProducts {
  final ProductsViewModel _productsViewModel = ProductsViewModel();
  final BuyViewModel _buyViewModel = BuyViewModel();
  bool _buying = false;

  void mostrar() {
    if (!_buying) {
      _productsViewModel.view();
      _buying = true;
    } else {
      _buyViewModel.view();
      _buying = false;
    }
  }
}

class ProductsViewModel {
  void view() {
    String input = '';
    do {
      print('Buy products (press 1)');
      input = readInput();
    } while (input != '1');
  }
}

class BuyViewModel {
  List<Product> _products = [];

  BuyViewModel() {
    ProductsService.productsStream.listen((event) => _products = event);
  }

  void view() {
    String input = '';
    do {
      ProductsService.customProductsStream.listen((_) {
        for (int i = 0; i < _products.length; i++) {
          Product product = _products.elementAt(i);
          print('---');
          print('Product ${i + 1}');
          print(product.name);
          print('Added by ' + product.added.user);
          print('---');
        }
        print('Buy product (press INDEX) or back (press 0)');
        input = readInput();
      });
    } while (input != '0');
  }
}

void main(List<String> arguments) {
  final TestBuyProducts testBuyProducts = TestBuyProducts();
  testBuyProducts.mostrar();
}
