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

  Map toMap() => {'name': name, 'deleted': deleted?.toMap()};

  @override
  int compareTo(other) => name.compareTo(other.name);
}
