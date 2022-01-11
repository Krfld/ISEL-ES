import './signature.dart';

class ShoppingList implements Comparable<ShoppingList> {
  final String id;

  final String name;
  final Signature? deleted;

  ShoppingList({
    required this.id,
    required this.name,
    required this.deleted,
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
    Map shoppingList = {'name': name};
    if (deleted != null) shoppingList['deleted'] = deleted!.toMap();
    return shoppingList;
  }

  @override
  int compareTo(other) => name.compareTo(other.name);
}
