import '../../.imports.dart';

class User {
  final String id;
  final String name;
  final List groups;

  User({
    required this.id,
    required this.name,
    required this.groups,
  });

  factory User.fromId(String userId) {
    List groups = Tools.loadList(Data.users, '$userId/groups', []);
    groups.removeWhere((element) => element == null);

    return User(
      id: userId,
      name: '',
      groups: groups,
    );
  }
}