import 'dart:async';
import '../models/group.dart';
import '../repositories/groups_repository.dart';

class GroupsService {
  static List<Group> groups = [];

  static String? _currentGroupId;
  static Group get currentGroup => getGroup(_currentGroupId!);
  static set currentGroup(Group? group) => _currentGroupId = group?.id;

  static Group getGroup(String groupId) => groups.singleWhere((group) => group.id == groupId);

  /// Streams

  static Stream<List<Group>> get firestoreGroupsStream => GroupsRepository.firestoreGroupsStream
      .map((snapshot) => snapshot.docs.map((doc) => Group.fromMap(doc.id, doc.data())).toList()..sort());

  static final StreamController<void> _groupsStreamController = StreamController.broadcast();
  static void sinkGroupsStream() => _groupsStreamController.sink.add(null);
  static Stream<void> get groupsStream => _groupsStreamController.stream;
}
