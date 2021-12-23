import '../../.imports.dart';

class AppUser implements Comparable {
  final String id;

  final String? name;
  final bool isGuest;

  AppUser({
    required this.id,
    required this.name,
    required this.isGuest,
  });

  factory AppUser.fromMap(String userId, Map userData) {
    return AppUser(
      id: userId,
      name: Tools.load(userData, 'name'),
      isGuest: Tools.loadBool(userData, 'isGuest', false),
    );
  }

  @override
  int compareTo(other) {
    return name!.compareTo((other as AppUser).name!);
  }
}
