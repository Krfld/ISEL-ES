import './signature.dart';

class Product implements Comparable<Product> {
  final String id;

  String name;
  String? brand;
  String? store;
  String? details;
  int? amount;
  int tag; // 0 - None | 1 - Important | 2 - Discount
  Signature added;
  Signature? bought;
  Signature? removed;

  Product({
    required this.id,
    required this.name,
    this.brand,
    this.store,
    this.details,
    this.amount,
    required this.tag,
    required this.added,
    this.bought,
    this.removed,
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
  String toString() {
    return 'Produto -> ID: $id | Name: $name | Comprado: ${bought != null ? 'Sim, por ${bought!.user}, em ${bought!.timestamp}' : 'Não'}\n';
  }

  @override
  int compareTo(other) => added.compareTo(other.added); //TODO Check if comparison matches (recent first)
}
