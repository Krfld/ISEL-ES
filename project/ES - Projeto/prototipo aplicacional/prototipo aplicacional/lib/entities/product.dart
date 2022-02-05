import 'package:cloud_firestore/cloud_firestore.dart';

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

  Map<String, dynamic> toMap() {
    Map<String, dynamic> product = {
      'name': name,
      'brand': brand ?? FieldValue.delete(),
      'store': store ?? FieldValue.delete(),
      'details': details ?? FieldValue.delete(),
      'amount': amount ?? FieldValue.delete(),
      'tag': tag,
      'added': added.toMap(),
      'bought': bought?.toMap() ?? FieldValue.delete(),
      'removed': removed?.toMap() ?? FieldValue.delete(),
    };

    return product;
  }

  @override
  int compareTo(other) => added.compareTo(other.added);
}
