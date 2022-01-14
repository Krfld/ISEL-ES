import 'package:firebase_auth/firebase_auth.dart';
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

  // static Stream<QuerySnapshot<Map<String, dynamic>>> col(String path) =>
  //     firestore.collection(path).orderBy('name').snapshots();
  // static Stream<DocumentSnapshot<Map<String, dynamic>>> doc(String path) => firestore.doc(path).snapshots();
}

/*
///
/// Realtime Database
///

class _RD {
  /// Database reference
  static final DatabaseReference _dbRef = FirebaseDatabase.instance.reference().child('');

  /// Generate token
  static String get token => _dbRef.push().key;

  /// Stream at 'path'
  static Stream<Map> stream(String path) =>
      _dbRef.child(path).onValue.map((event) => event.snapshot.value is Map ? event.snapshot.value : {});

  /*/// Private setup
  static void _setup() {
    _dbRef.onValue
        .listen((event) => Data.update(event.snapshot.value is Map ? event.snapshot.value : {}))
        .onError((e) => Tools.print(e, prefix: 'OnValue', isError: true));
  }*/

  /// Write data
  static Future<void> write(String path, var value) async {
    try {
      await _dbRef.update({path: value});
    } catch (e) {
      Log.print(e, prefix: 'Write', isError: true);
    }
  }

  /// Replace data
  static Future<void> replace(String path, var value) async {
    try {
      await _dbRef.set({path: value});
    } catch (e) {
      Log.print(e, prefix: 'Write', isError: true);
    }
  }

  /// Read data
  static Future<dynamic> read(String path) async {
    try {
      return (await _dbRef.child(path).get()).value;
    } catch (e) {
      Log.print(e, prefix: 'Read', isError: true);
    }
  }

  /// Set timestamp
  static Future<void> setTimestamp(String path) async {
    await write(path, ServerValue.timestamp);
    //return (await db.read(path))?.toInt() ?? 0;
  }

  /*/// Push data and get token
  static Future<String?> push(String path, var value) async {
    try {
      DatabaseReference reference = _dbRef.child(path).push();
      await reference.set(value);
      return reference.key;
    } catch (e) {
      Tools.print(e, prefix: 'Push', isError: true);
    }
  }

  /// Delete data
  static Future<void> delete(String path) async {
    try {
      await _dbRef.child(path).remove();
    } catch (e) {
      Tools.print(e, prefix: 'Delete', isError: true);
    }
  }*/
}
*/