import 'package:cloud_firestore/cloud_firestore.dart';

import './signature.dart';

class ShoppingList implements Comparable<ShoppingList> {
  final String id;

  String name;
  Signature? deleted;

  ShoppingList({
    required this.id,
    required this.name,
    this.deleted,
  });

  factory ShoppingList.fromMap(String listId, Map listData) {
    Map? deleted = listData['deleted'];

    return ShoppingList(
      id: listId,
      name: listData['name'],
      deleted: deleted != null ? Signature.fromMap(deleted) : null,
    );
  }

  Map toMap() {
    Map shoppingList = {'name': name, 'deleted': deleted ?? FieldValue.delete()};
    return shoppingList;
  }

  @override
  int compareTo(other) => name.compareTo(other.name);
}
