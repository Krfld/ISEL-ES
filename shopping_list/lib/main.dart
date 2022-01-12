import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;

import './modules/firebase.dart';
import './imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  Future<bool> setup() async {
    if (!await FC.init()) return false;

    await Tools.delay(seconds: 1);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        'Home': (context) => Home(),
        'Groups': (context) => Groups(),
        'Lists': (context) => Lists(),
        'Products': (context) => Products(),
      },
      home: FutureBuilder<bool>(
        future: setup(),
        builder: (context, setup) {
          return setup.data ?? false ? Groups() : LoadingScreen();
        },
      ),
    );
  }
}
