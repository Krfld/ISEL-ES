import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import './.imports.dart';

_Firebase fb = _Firebase();

class _Firebase {
  /*Future get now async {
    await write('|timestamps/now', ServerValue.timestamp);
    return app.load(data.timestamps, 'now', 0);
  }*/

  Future setup() async {
    await Firebase.initializeApp();

    FirebaseDatabase.instance.reference().child('').onValue.listen((event) {
      app.msg(event.snapshot.value);
    });
  }
}
