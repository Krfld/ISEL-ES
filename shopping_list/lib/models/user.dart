class AppUser implements Comparable<AppUser> {
  final String id;

  final String? name;
  final bool isGuest;

  AppUser({
    required this.id,
    required this.name,
    required this.isGuest,
  });

  AppUser.fromMap(String userId, Map userData)
      : id = userId,
        name = userData['name'],
        isGuest = userData['isGuest'];

  Map toMap() => {'name': name, 'isGuest': isGuest};

  @override
  int compareTo(other) => name!.compareTo(other.name!);

  void createGroup() {}
}
