import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/firebase.dart';

import '../entities/group.dart';

class GroupsRepository {
  Stream<List<Group>> groupsStream() => CF.firestoreInstance
      .collection('groups')
      .where('users', arrayContains: FA.user.id)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Group.fromMap(doc.id, doc.data())).toList()..sort());

  Future<void> createGroup(String groupName) async => await CF.addDocument('groups', {
        'name': groupName,
        'users': [FA.user.id],
      });

  Future<bool> joinGroup(String groupId) async => await CF.updateDocument('groups/$groupId', {
        'users': FieldValue.arrayUnion([FA.user.id]),
      });

  Future<bool> updateGroup(String groupId, String groupName) async => await CF.updateDocument('groups/$groupId', {
        'name': groupName,
      });
}
