import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import './.imports.dart';

_Firebase fb = _Firebase();

class _Firebase {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference().child('');

  Future<int> get now async {
    await write('|timestamps/now', ServerValue.timestamp);
    return (await read('|timestamps/now'))?.toInt() ?? 0;
  }

  Future<void> setup() async {
    app.msg(await Firebase.initializeApp());

    _dbRef.onValue.listen((data) {
      app.msg(data.snapshot.value, prefix: 'Data');
    }).onError((e) => app.msg(e, prefix: 'Data', isError: true));

    await app.delay(seconds: 3);
  }

  Future<void> write(String path, var value) async {
    try {
      await _dbRef.update({path: value});
    } catch (e) {
      app.msg(e, prefix: 'Write', isError: true);
    }
  }

  Future<String?> push(String path, var value) async {
    try {
      DatabaseReference reference = _dbRef.child(path).push();
      await reference.set(value);
      return reference.key;
    } catch (e) {
      app.msg(e, prefix: 'Push', isError: true);
    }
  }

  Future<dynamic> read(String path) async {
    try {
      return (await _dbRef.child(path).get()).value;
    } catch (e) {
      app.msg(e, prefix: 'Read', isError: true);
    }
  }

  Future<void> delete(String path) async {
    try {
      await _dbRef.child(path).remove();
    } catch (e) {
      app.msg(e, prefix: 'Delete', isError: true);
    }
  }
}
