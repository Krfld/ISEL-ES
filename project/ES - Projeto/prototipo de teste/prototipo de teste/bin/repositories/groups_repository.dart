import 'dart:math';

import '../entities/group.dart';

abstract class GroupsRepository {
  Stream<List<Group>> groupsStream();
  Future<void> createGroup(String groupName);
}

class GroupsRepositoryTest implements GroupsRepository {
  final List<Group> groups = [
    Group(id: 'g1', name: 'group 1', users: ['u1']),
    Group(id: 'g2', name: 'group 2', users: ['u1', 'u2']),
    Group(id: 'g3', name: 'group 3', users: ['u2']),
  ];

  // Filter groups where current user is a member
  @override
  Stream<List<Group>> groupsStream() => Stream.value(groups.where((element) => element.users.contains('u1')).toList());

  // Forçar id a 'g4' para comparar com o esperado
  @override
  Future<void> createGroup(String groupName) async => groups.add(Group(id: 'g4', name: groupName, users: ['u1']));
}
