import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './../classes/user.dart';
import './../modules/tools.dart';

///
/// Firebase Core
///

class FC {
  /// Init firebase and sign in
  static Future<bool> init() async {
    await Firebase.initializeApp();

    bool signedIn = await FA.signInAnonymously();

    if (!signedIn) Log.print('Didn\'t signIn', prefix: 'SignIn', isError: true);

    return signedIn;
  }
}

///
/// Firebase Authentication
///

class FA {
  static AppUser? _user;
  static AppUser get user => _user!;

  /// Authentication instance
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<bool> signInAnonymously() async {
    try {
      String userId = (await _auth.signInAnonymously()).user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).get().then((doc) async {
        if (!doc.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({'isGuest': true}, SetOptions(merge: true));

          _user = AppUser.fromMap(userId, {'isGuest': true});
        } else
          _user = AppUser.fromMap(userId, doc.data()!);
      });

      return true;
    } catch (error) {
      Log.print(error, prefix: 'SignInAnonymously', isError: true);
      return false;
    }
  }
}

///
/// Cloud Firestore
///

class CF {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<DocumentReference<Map<String, dynamic>>> addToCollection(
          String path, Map<String, dynamic> data) async =>
      await firestore.collection(path).add(data);

  static Future<void> updateDocument(String path, Map<String, dynamic> data, {bool merge = false}) async =>
      await firestore.doc(path).set(data, SetOptions(merge: merge));

  // static Stream<QuerySnapshot<Map<String, dynamic>>> col(String path) =>
  //     firestore.collection(path).orderBy('name').snapshots();
  // static Stream<DocumentSnapshot<Map<String, dynamic>>> doc(String path) => firestore.doc(path).snapshots();
}

/*
///
/// Realtime Database
///

class RD {
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