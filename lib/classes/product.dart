import '../../.imports.dart';

class Product {
  final String id;
  final String name;
  final DateTime added;
  final String? brand;
  final String? store;
  final String? info;
  final int? amount;
  final bool bought;
  final bool important;
  final bool onDiscount;

  Product({
    required this.id,
    required this.name,
    required this.added,
    required this.brand,
    required this.store,
    required this.info,
    required this.amount,
    required this.bought,
    required this.important,
    required this.onDiscount,
  });

  factory Product.fromMap(String groupId, String listId, String productId, Map data) {
    Map product = Tools.loadMap(data, '$groupId/lists/$listId/products/$productId', {});

    return Product(
      id: productId,
      name: Tools.loadString(product, 'name', ''),
      added: DateTime.fromMillisecondsSinceEpoch(Tools.loadInt(product, 'added', 0)),
      brand: Tools.load(product, 'brand'),
      store: Tools.load(product, 'store'),
      info: Tools.load(product, 'info'),
      amount: Tools.load(product, 'amount'),
      bought: Tools.loadBool(product, 'bought', false),
      important: Tools.loadBool(product, 'important', false),
      onDiscount: Tools.loadBool(product, 'onDiscount', false),
    );
  }
}
