import 'dart:async';
import '../entities/group.dart';
import '../repositories/groups_repository.dart';

class GroupsService {
  static final GroupsRepository _groupsRepository = GroupsRepositoryCloudFirestore();

  // Lista de grupos que estará sempre atualizada
  static List<Group> groups = [];

  // Guardar informação do grupo que o utilizador entrou
  static String? _currentGroupId;
  static Group get currentGroup => getGroup(_currentGroupId!);
  static set currentGroup(Group? group) => _currentGroupId = group?.id;

  // Obter um grupo da lista de grupos que está sempre atualizada
  static Group getGroup(String groupId) => groups.singleWhere((group) => group.id == groupId);

  /// Operations

  static Future<void> createGroup(String groupName) => _groupsRepository.createGroup(groupName);

  /// Streams

  // Stream que atualiza a lista de grupos sempre que houver uma alteração
  static Stream<List<Group>> get groupsStream => _groupsRepository.groupsStream();

  // Stream para atualizar os widgets nas vistas sempre que houver uma alteração
  static final StreamController<void> _customGroupsStreamController = StreamController.broadcast();
  static void sinkCustomGroupsStream() => _customGroupsStreamController.sink.add(null);
  static Stream<void> get customGroupsStream => _customGroupsStreamController.stream;
}
