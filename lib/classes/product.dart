import '../../.imports.dart';

class Product {
  final String id;
  final String name;
  final DateTime added;
  final String? brand;
  final String? store;
  final String? info;
  final int? amount;
  final bool flag;

  Product({
    required this.id,
    required this.name,
    required this.added,
    required this.brand,
    required this.store,
    required this.info,
    required this.amount,
    required this.flag,
  });

  factory Product.fromId(String groupId, String listId, String productId) {
    Map product = Tools.loadMap(Data.data, '$groupId/lists/$listId/products/$productId', {});

    return Product(
      id: productId,
      name: Tools.loadString(product, 'name', ''),
      added: DateTime.fromMillisecondsSinceEpoch(Tools.loadInt(product, 'added', 0)),
      brand: Tools.load(product, 'brand'),
      store: Tools.load(product, 'store'),
      info: Tools.load(product, 'info'),
      amount: Tools.load(product, 'amount'),
      flag: Tools.loadBool(product, 'flag', false),
    );
  }
}
