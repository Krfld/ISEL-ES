// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
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
    while (true) {
      if (!_buying) {
        _productsViewModel.view();
        _buying = true;
      } else {
        _buyViewModel.view();
        _buying = false;
      }
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
  BuyViewModel() {
    ProductsService.productsStream.listen((event) {
      print(event);
      ProductsService.products = event;
    });
  }

  void view() {
    StreamSubscription streamSubscription = ProductsService.productsStream.listen((products) {
      ProductsService.products = products;

      if (products.isEmpty)
        print('Not products to buy');
      else
        for (int i = 0; i < ProductsService.products.length; i++) {
          Product product = ProductsService.products.elementAt(i);
          print('---');
          print('Product ${i + 1}');
          print(product.name);
          print('Added by ' + product.added.user);
          print('---');
        }

      // print('Buy product (press INDEX) or back (press 0)');
    });
    ProductsService.setupTest();

    String input = '';
    int productIndex = -1;
    do {
      print('Buy product (press INDEX) or back (press 0)');
      input = readInput();
      if (input == '0') break;

      try {
        productIndex = int.parse(input) - 1;
        ProductsService.buyProduct(ProductsService.products.elementAt(productIndex)); //! Error
      } catch (e) {
        print('Not int');
      }

      print('Selected product $productIndex');
    } while (input != '0');
    streamSubscription.cancel();
  }
}

void main(List<String> arguments) {
  final TestBuyProducts testBuyProducts = TestBuyProducts();
  testBuyProducts.mostrar();
}
