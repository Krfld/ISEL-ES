import '../../.imports.dart';

class Group {
  final String id;
  final String name;
  final List lists;

  Group({
    required this.id,
    required this.name,
    required this.lists,
  });

  factory Group.fromId(String groupId) {
    Map group = Tools.loadMap(Data.data, groupId, {});

    Iterable lists = Tools.loadMap(group, 'lists', {}).keys;
    List groupLists = List.generate(lists.length, (index) => lists.elementAt(index));

    return Group(
      id: groupId,
      name: Tools.loadString(group, 'name', ''),
      lists: groupLists,
    );
  }
}
