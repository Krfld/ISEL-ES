import '../../.imports.dart';

class Product {
  final String id;
  final String listId;
  final String groupId;

  final String name;
  final DateTime added; //? Check if needed
  final String? brand;
  final String? store;
  final String? info;
  final int? amount;
  final DateTime? bought; //! Map
  final int tag; // 0 - None | 1 - Important | 2 - Discount

  Product({
    required this.id,
    required this.listId,
    required this.groupId,
    required this.name,
    required this.added,
    required this.brand,
    required this.store,
    required this.info,
    required this.amount,
    required this.bought,
    required this.tag,
  });

  factory Product.fromMap(String groupId, String listId, String productId, Map data) {
    Map product = Tools.loadMap(data, '$groupId/lists/$listId/products/$productId', {});

    int? bought = Tools.load(product, 'bought');

    return Product(
      id: productId,
      listId: listId,
      groupId: groupId,
      name: Tools.loadString(product, 'name', ''),
      added: DateTime.fromMillisecondsSinceEpoch(Tools.loadInt(product, 'added', 0)),
      brand: Tools.load(product, 'brand'),
      store: Tools.load(product, 'store'),
      info: Tools.load(product, 'info'),
      amount: Tools.load(product, 'amount'),
      bought: bought != null ? DateTime.fromMillisecondsSinceEpoch(Tools.loadInt(product, 'bought', 0)) : null,
      tag: Tools.loadInt(product, 'tag', 0),
    );
  }
}
