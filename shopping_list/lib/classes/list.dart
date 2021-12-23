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

  ShoppingList.fromMap(String listId, Map listData)
      : id = listId,
        name = listData['name'],
        deleted = Signature.fromMap(listData['deleted']);

  Map toMap() => {'name': name, 'deleted': deleted?.toMap()};

  @override
  int compareTo(other) => name.compareTo(other.name);
}
