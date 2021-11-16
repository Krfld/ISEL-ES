import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../.imports.dart';

///
/// Firebase
///

class FB {
  static bool _inited = false;

  static Stream<Event>? _stream;
  static Stream<Event>? get stream => _stream;

  /// Init firebase
  static Future<bool> init() async {
    if (_inited) return !_inited;

    await Firebase.initializeApp();

    _stream = DB._setup();

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

  /// Private setup
  static Stream<Event> _setup() {
    Stream<Event> stream = _dbRef.onValue;
    stream
        .listen((event) => Data.update(event.snapshot.value is Map ? event.snapshot.value : {}))
        .onError((e) => Tools.msg(e, prefix: 'Data', isError: true));

    return stream;
  }

  /// Set timestamp
  static Future<void> setTimestamp(String path) async {
    await write(path, ServerValue.timestamp);
    //return (await db.read(path))?.toInt() ?? 0;
  }

  /// Write data
  static Future<void> write(String path, var value) async {
    try {
      await _dbRef.update({path: value});
    } catch (e) {
      Tools.msg(e, prefix: 'Write', isError: true);
    }
  }

  /// Push data and get token
  static Future<String?> push(String path, var value) async {
    try {
      DatabaseReference reference = _dbRef.child(path).push();
      await reference.set(value);
      return reference.key;
    } catch (e) {
      Tools.msg(e, prefix: 'Push', isError: true);
    }
  }

  /// Replace data
  static Future<void> replace(String path, var value) async {
    try {
      await _dbRef.set({path: value});
    } catch (e) {
      Tools.msg(e, prefix: 'Write', isError: true);
    }
  }

  /// Read data
  static Future<dynamic> read(String path) async {
    try {
      return (await _dbRef.child(path).get()).value;
    } catch (e) {
      Tools.msg(e, prefix: 'Read', isError: true);
    }
  }

  /// Delete data
  static Future<void> delete(String path) async {
    try {
      await _dbRef.child(path).remove();
    } catch (e) {
      Tools.msg(e, prefix: 'Delete', isError: true);
    }
  }
}

class FA {}
