import 'dart:async';
import '../entities/group.dart';
import '../repositories/groups_repository.dart';

class GroupsService {
  static final GroupsRepository _groupsRepository = GroupsRepositoryCloudFirestore();

  static List<Group> groups = [];

  static String? _currentGroupId;
  static Group get currentGroup => getGroup(_currentGroupId!);
  static set currentGroup(Group? group) => _currentGroupId = group?.id;

  static Group getGroup(String groupId) => groups.singleWhere((group) => group.id == groupId);

  /// Operations

  static Future<void> createGroup(String groupName) => _groupsRepository.createGroup(groupName);

  /// Streams

  static Stream<List<Group>> get groupsStream => _groupsRepository.groupsStream();

  static final StreamController<void> _customGroupsStreamController = StreamController.broadcast();
  static void sinkCustomGroupsStream() => _customGroupsStreamController.sink.add(null);
  static Stream<void> get customGroupsStream => _customGroupsStreamController.stream;
}
