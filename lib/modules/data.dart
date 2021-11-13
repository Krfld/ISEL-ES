import '../.imports.dart';

_Data data = _Data();
_Users users = _Users();
_Groups groups = _Groups();

class _Data {
  Map _data = {};

  void update(Map data) {
    _data = data;
    app.msg(data, prefix: 'Data');

    users.update(app.load(data, 'users', {}));
    groups.update(app.load(data, 'groups', {}));
  }
}

class _Users {
  Map _users = {};

  void update(Map users) {
    _users = users;
  }
}

class _Groups {
  Map _groups = {};

  List get groups => _groups.keys.toList();

  void update(Map groups) {
    _groups = groups;
  }
}
