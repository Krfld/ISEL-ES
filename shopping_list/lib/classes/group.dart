class Group implements Comparable<Group> {
  final String id;
  final String name;
  final List users;

  Group({
    required this.id,
    required this.name,
    required this.users,
  });
  Group.fromMap(String groupId, Map groupData)
      : id = groupId,
        name = groupData['name'],
        users = groupData['users'];

  Map toMap() => {'name': name, 'users': users};

  @override
  int compareTo(other) => name.compareTo(other.name);
}
