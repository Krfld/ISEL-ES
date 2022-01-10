import './signature.dart';

class Product implements Comparable<Product> {
  final String id;

  final String name;
  final String? brand;
  final String? store;
  final String? details;
  final int? amount;
  final int tag; // 0 - None | 1 - Important | 2 - Discount
  final Signature added;
  final Signature? bought;
  final Signature? removed;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.store,
    required this.details,
    required this.amount,
    required this.tag,
    required this.added,
    required this.bought,
    required this.removed,
  });

  factory Product.fromMap(String productId, Map productData) {
    Map? bought = productData['bought'];
    Map? removed = productData['removed'];

    return Product(
      id: productId,
      name: productData['name'],
      brand: productData['brand'],
      store: productData['store'],
      details: productData['details'],
      amount: productData['amount'],
      tag: productData['tag'],
      added: Signature.fromMap(productData['added']),
      bought: bought != null ? Signature.fromMap(bought) : null,
      removed: removed != null ? Signature.fromMap(removed) : null,
    );
  }

  Map toMap() {
    Map product = {
      'name': name,
      //'brand': brand,
      //'store': store,
      //'details': details,
      //'amount': amount,
      'tag': tag,
      'added': added.toMap(),
      //'bought': bought?.toMap(),
      //'removed': removed?.toMap(),
    };

    if (brand != null) product['brand'] = brand;
    if (store != null) product['store'] = store;
    if (details != null) product['details'] = details;
    if (amount != null) product['amount'] = amount;
    if (bought != null) product['bought'] = bought!.toMap();
    if (removed != null) product['removed'] = removed!.toMap();

    return product;
  }

  @override
  int compareTo(other) => added.compareTo(other.added); //TODO Check if comparison matches (recent first)

}
