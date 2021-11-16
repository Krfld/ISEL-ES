import '../.imports.dart';

_Data data = _Data();
_Users users = _Users();
_Groups groups = _Groups();
_Lists lists = _Lists();

class _Data {
  Map _data = {};

  void update(Map data) {
    _data = data;
    app.msg(data, prefix: 'Data');

    users._update(app.loadMap(data, 'users', {}));
    groups._update(app.loadMap(data, 'groups', {}));
  }
}

class _Users {
  Map _users = {};

  void _update(Map users) {
    _users = users;
  }

  String name(String id) => app.loadString(_users, 'users/$id/name', '');
}

class _Groups {
  Map _groups = {};

  void _update(Map groups) {
    _groups = groups;
  }

  List get groups => _groups.keys.toList();

  String groupName(String id) => app.loadString(_groups, 'groups/$id/name', '');
}

class _Lists {
  Map _lists = {};

  List get lists => _lists.keys.toList();
}
