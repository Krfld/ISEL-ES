import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/group.dart';

abstract class GroupsRepository {
  Stream<List<Group>> groupsStream();
}

class GroupsRepositoryCloudFirestore implements GroupsRepository {
  static final FirebaseFirestore _instance = FirebaseFirestore.instance;

  @override
  Stream<List<Group>> groupsStream() => _instance
      .collection('test_groups')
      .where('users', arrayContains: 'u1')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Group.fromMap(doc.id, doc.data())).toList()..sort());
}
