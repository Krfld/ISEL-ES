import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../.imports.dart';

_Firebase fb = _Firebase();
_RealtimeDatabase db = _RealtimeDatabase();

class _Firebase {
  bool _inited = false;

  Future<void> init() async {
    if (_inited) return;

    await Firebase.initializeApp();

    db._setup();

    await app.delay(seconds: 3); //! Temp

    _inited = true;
  }
}

class _RealtimeDatabase {
  ///* Private setup
  Stream<Event> _setup() {
    Stream<Event> data = _dbRef.onValue;

    data.listen((data) {
      app.msg(data.snapshot.value, prefix: 'Data');
    }).onError((e) => app.msg(e, prefix: 'Data', isError: true));

    return data;
  }

  Map data = {};

  /// Database reference
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference().child('');

  /// Get firebase timestamp
  Future<int> get now async {
    await write('|timestamps/now', ServerValue.timestamp);
    return (await read('|timestamps/now'))?.toInt() ?? 0;
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
