import '../../.imports.dart';

class GroupList implements Comparable {
  final String id;
  //final String groupId;

  final String name;
  final DateTime? deleted;
  // final List products;

  GroupList({
    required this.id,
    //required this.groupId,
    required this.name,
    required this.deleted,
    // required this.products,
  });

  factory GroupList.fromMap(String listId, Map listData) {
    // Iterable products = Tools.loadMap(listData, 'products', {}).keys;
    // List listProducts = List.generate(products.length, (index) => products.elementAt(index));

    int? deleted = Tools.load(listData, 'deleted');

    return GroupList(
      id: listId,
      //groupId: groupId,
      name: Tools.loadString(listData, 'name', ''),
      deleted: deleted != null ? DateTime.fromMillisecondsSinceEpoch(deleted) : null,
      // products: listProducts,
    );
  }

  @override
  int compareTo(other) {
    return name.compareTo(other.name);
  }
}
