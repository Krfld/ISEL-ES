import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../.imports.dart';

///
/// Firebase
///

class FB {
  static bool _inited = false;

  /// Init firebase
  static Future<bool> init() async {
    if (_inited) return !_inited;

    await Firebase.initializeApp();

    Data.setup();

    await Tools.delay(seconds: 2); //! Temp

    return _inited = true;
  }
}

///
/// Realtime Database
///

class DB {
  /// Database reference
  static final DatabaseReference _dbRef = FirebaseDatabase.instance.reference().child('');

  /// Get token
  static String get token => _dbRef.push().key;

  static Stream<Event> stream(String path) => _dbRef.child(path).onValue;

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
      Tools.print(e, prefix: 'Write', isError: true);
    }
  }

  /// Replace data
  static Future<void> replace(String path, var value) async {
    try {
      await _dbRef.set({path: value});
    } catch (e) {
      Tools.print(e, prefix: 'Write', isError: true);
    }
  }

  /// Read data
  static Future<dynamic> read(String path) async {
    try {
      return (await _dbRef.child(path).get()).value;
    } catch (e) {
      Tools.print(e, prefix: 'Read', isError: true);
    }
  }

  /*/// Set timestamp
  static Future<void> setTimestamp(String path) async {
    await write(path, ServerValue.timestamp);
    //return (await db.read(path))?.toInt() ?? 0;
  }*/

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

class FA {}
