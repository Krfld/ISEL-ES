import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import './.imports.dart';

_Firebase fb = _Firebase();

class _Firebase {
  DatabaseReference get dbRef => FirebaseDatabase.instance.reference();

  /*Future get now async {
    await write('|timestamps/now', ServerValue.timestamp);
    return app.load(data.timestamps, 'now', 0);
  }*/

  Future setup() async {
    await Firebase.initializeApp();

    dbRef.onValue.listen((data) {
      app.msg(data.snapshot.value);
    });

    await Future.delayed(Duration(seconds: 2));
  }
}
