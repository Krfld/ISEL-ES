import 'package:firebase_database/firebase_database.dart';

import './.imports.dart';

_Firebase fb = _Firebase();

class _Firebase {
  Future setup() async {
    app.msg('Setup');
    FirebaseDatabase.instance.reference().onValue.listen((event) {
      app.msg(event);
    });
  }
}
