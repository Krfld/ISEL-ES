import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../.imports.dart';

_FirebaseCore fb = _FirebaseCore();
_FirebaseDatabase db = _FirebaseDatabase();

///
/// Firebase
///

class _FirebaseCore {
  bool _inited = false;

  Stream<Event>? _stream;
  Stream<Event>? get stream => _stream;

  /// Init firebase
  Future<bool> init() async {
    if (_inited) return !_inited;

    await Firebase.initializeApp();

    _stream = db._setup();

    await app.delay(seconds: 2); //! Temp

    return _inited = true;
  }
}

///
/// Realtime Database
///

class _FirebaseDatabase {
  /// Database reference
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference().child('');

  /// Private setup
  Stream<Event> _setup() {
    Stream<Event> stream = _dbRef.onValue;
    stream
        .listen((event) => data.update(event.snapshot.value is Map ? event.snapshot.value : {}))
        .onError((e) => app.msg(e, prefix: 'Data', isError: true));

    return stream;
  }

  /// Set timestamp
  Future<void> setTimestamp(String path) async {
    await write(path, ServerValue.timestamp);
    //return (await db.read(path))?.toInt() ?? 0;
  }

  /// Write data to firebase
  Future<void> write(String path, var value) async {
    try {
      await _dbRef.update({path: value});
    } catch (e) {
      app.msg(e, prefix: 'Write', isError: true);
    }
  }

  /// Push data from firebase
  Future<String?> push(String path, var value) async {
    try {
      DatabaseReference reference = _dbRef.child(path).push();
      await reference.set(value);
      return reference.key;
    } catch (e) {
      app.msg(e, prefix: 'Push', isError: true);
    }
  }

  /// Read data from firebase
  Future<dynamic> read(String path) async {
    try {
      return (await _dbRef.child(path).get()).value;
    } catch (e) {
      app.msg(e, prefix: 'Read', isError: true);
    }
  }

  /// Delete data from firebase
  Future<void> delete(String path) async {
    try {
      await _dbRef.child(path).remove();
    } catch (e) {
      app.msg(e, prefix: 'Delete', isError: true);
    }
  }
}

class _FirebaseAuth {}
