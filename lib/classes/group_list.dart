import '../../.imports.dart';

class GroupList {
  final String id;
  final String name;
  final List products;

  GroupList({
    required this.id,
    required this.name,
    required this.products,
  });

  factory GroupList.fromMap(String groupId, String listId, Map data) {
    Map list = Tools.loadMap(data, '$groupId/lists/$listId', {});

    Iterable products = Tools.loadMap(list, 'products', {}).keys;
    List listProducts = List.generate(products.length, (index) => products.elementAt(index));

    return GroupList(
      id: listId,
      name: Tools.loadString(list, 'name', ''),
      products: listProducts,
    );
  }
}
