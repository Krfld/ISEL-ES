import '../../.imports.dart';

class Product implements Comparable {
  final String id;
  //final String listId;
  //final String groupId;

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
    //required this.listId,
    //required this.groupId,
    required this.name,
    required this.added,
    required this.brand,
    required this.store,
    required this.info,
    required this.amount,
    required this.bought,
    required this.tag,
  });

  factory Product.fromMap(String productId, Map productData) {
    int? bought = Tools.load(productData, 'bought');

    return Product(
      id: productId,
      //listId: listId,
      //groupId: groupId,
      name: Tools.loadString(productData, 'name', ''),
      added: DateTime.fromMillisecondsSinceEpoch(Tools.loadInt(productData, 'added', 0)),
      brand: Tools.load(productData, 'brand'),
      store: Tools.load(productData, 'store'),
      info: Tools.load(productData, 'info'),
      amount: Tools.load(productData, 'amount'),
      bought: bought != null ? DateTime.fromMillisecondsSinceEpoch(Tools.loadInt(productData, 'bought', 0)) : null,
      tag: Tools.loadInt(productData, 'tag', 0),
    );
  }

  @override
  int compareTo(other) {
    return added.compareTo(other.added); //TODO Check if comparison matches (recent first)
  }
}
