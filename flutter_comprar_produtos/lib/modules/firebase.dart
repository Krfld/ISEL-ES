import 'package:cloud_firestore/cloud_firestore.dart';

/// Cloud Firestore

class CF {
  static final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  static FirebaseFirestore get firestoreInstance => _firestoreInstance;

  static Future<DocumentReference<Map<String, dynamic>>> addDocument(String path, Map<String, dynamic> doc) async =>
      await _firestoreInstance.collection(path).add(doc);

  static Future<void> setDocument(String path, Map<String, dynamic> doc, {bool merge = false}) async =>
      await _firestoreInstance.doc(path).set(doc, SetOptions(merge: merge));

  static Future<bool> updateDocument(String path, Map<String, dynamic> doc) async {
    try {
      await _firestoreInstance.doc(path).update(doc);
      return true;
    } catch (e) {
      return false;
    }
  }
}
