import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/group.dart';

abstract class GroupsRepository {
  Stream<List<Group>> groupsStream();
  Future<void> createGroup(String groupName);
}

class GroupsRepositoryCloudFirestore implements GroupsRepository {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  @override
  Stream<List<Group>> groupsStream() => _instance
      .collection('test_groups')
      .where('users', arrayContains: 'u1')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Group.fromMap(doc.id, doc.data())).toList()..sort());

  @override
  Future<void> createGroup(String groupName) async => await _instance.collection('test_groups').add({
        'name': groupName,
        'users': ['u1'],
      });

}
