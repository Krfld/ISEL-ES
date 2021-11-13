import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../.imports.dart';

_Firebase fb = _Firebase();
_RealtimeDatabase db = _RealtimeDatabase();

///
/// Firebase
///

class _Firebase {
  bool _inited = false;

  Stream<Event>? stream;

  /// Init firebase
  Future<void> init() async {
    if (_inited) return;

    await Firebase.initializeApp();

    stream = db._setup();

    await app.delay(seconds: 2); //! Temp

    _inited = true;
  }

  /// Get timestamp
  Future<int> get now async {
    await db.write('|timestamps/now', ServerValue.timestamp);
    return (await db.read('|timestamps/now'))?.toInt() ?? 0;
  }
}

///
/// Realtime Database
///

class _RealtimeDatabase {
  /// Database reference
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference().child('');

  ///* Private setup
  Stream<Event> _setup() {
    Stream<Event> stream = _dbRef.onValue;

    stream
        .listen((event) => data.update(app.load(event.snapshot.value, '', {})))
        .onError((e) => app.msg(e, prefix: 'Data', isError: true));

    return stream;
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
