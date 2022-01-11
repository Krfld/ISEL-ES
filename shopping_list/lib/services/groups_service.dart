import 'dart:async';
import '../models/group.dart';
import '../repositories/groups_repository.dart';

class GroupsService {
  static final GroupsRepository _groupsRepository = GroupsRepository();

  static List<Group> groups = [];

  static String? _currentGroupId;
  static Group get currentGroup => getGroup(_currentGroupId!);
  static set currentGroup(Group? group) => _currentGroupId = group?.id;

  static Group getGroup(String groupId) => groups.singleWhere((group) => group.id == groupId);

  /// Repository

  static Future<void> createGroup(String groupName) => _groupsRepository.createGroup(groupName);
  static Future<bool> joinGroup(String groupId) => _groupsRepository.joinGroup(groupId);
  static Future<bool> updateGroup(String groupId, String groupName) =>
      _groupsRepository.updateGroup(groupId, groupName);

  /// Streams

  static Stream<List<Group>> get firestoreGroupsStream => _groupsRepository.firestoreGroupsStream
      .map((snapshot) => snapshot.docs.map((doc) => Group.fromMap(doc.id, doc.data())).toList()..sort());

  static final StreamController<void> _groupsStreamController = StreamController.broadcast();
  static void sinkGroupsStream() => _groupsStreamController.sink.add(null);
  static Stream<void> get groupsStream => _groupsStreamController.stream;
}
