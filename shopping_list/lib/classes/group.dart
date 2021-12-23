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

  factory Group.fromMap(String groupId, Map groupData) {
    Iterable lists = Tools.loadMap(groupData, 'lists', {}).keys;
    List groupLists = List.generate(lists.length, (index) => lists.elementAt(index));

    return Group(
      id: groupId,
      name: Tools.loadString(groupData, 'name', ''),
      lists: groupLists,
    );
  }
}
