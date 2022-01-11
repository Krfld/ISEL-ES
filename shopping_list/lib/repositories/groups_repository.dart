import 'package:cloud_firestore/cloud_firestore.dart';
import '../modules/firebase.dart';

class GroupsRepository {
  Stream<QuerySnapshot<Map<String, dynamic>>> get firestoreGroupsStream =>
      CF.firestoreInstance.collection('groups').where('users', arrayContains: FA.user.id).snapshots();

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
