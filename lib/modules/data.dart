import '../.imports.dart';

_Data data = _Data();
_Users users = _Users();

class _Data {
  Map _data = {};

  void update(Map data) {
    _data = data;
    app.msg(data, prefix: 'Data');

    users.update(app.load(data, 'users', {}));
  }
}

class _Users {
  Map _users = {};

  void update(Map users) {
    _users = users;
    app.msg(users, prefix: 'Users');
  }
}
