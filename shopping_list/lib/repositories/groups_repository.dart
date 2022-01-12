import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/firebase.dart';

import '../entities/group.dart';

abstract class GroupsRepository {
  Stream<List<Group>> groupsStream();
  Future<void> createGroup(String groupName);
  Future<bool> joinGroup(String groupId);
  Future<bool> updateGroup(String groupId, String groupName);
}

class GroupsRepositoryCloudFirestore implements GroupsRepository {
  @override
  Stream<List<Group>> groupsStream() => CF.firestoreInstance
      .collection('groups')
      .where('users', arrayContains: FA.user.id)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Group.fromMap(doc.id, doc.data())).toList()..sort());

  @override
  Future<void> createGroup(String groupName) async => await CF.addDocument('groups', {
        'name': groupName,
        'users': [FA.user.id],
      });

  @override
  Future<bool> joinGroup(String groupId) async => await CF.updateDocument('groups/$groupId', {
        'users': FieldValue.arrayUnion([FA.user.id]),
      });

  @override
  Future<bool> updateGroup(String groupId, String groupName) async => await CF.updateDocument('groups/$groupId', {
        'name': groupName,
      });
}
