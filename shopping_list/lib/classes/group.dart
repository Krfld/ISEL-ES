class Group implements Comparable<Group> {
  final String? _id;
  String? get id => _id;

  final String _name;
  String get name => _name;

  final List _users;
  List get users => _users;

  Group(this._id, this._name, this._users);

  Group.fromMap(String groupId, Map groupData)
      : _id = groupId,
        _name = groupData['name'],
        _users = groupData['users'];

  Map toMap() => {'name': _name, 'users': _users};

  @override
  int compareTo(other) => _name.compareTo(other._name);
}
