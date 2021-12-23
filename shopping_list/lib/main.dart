import 'package:flutter/material.dart';
import './modules/firebase.dart';

import './imports.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static bool _inited = false;

  Future<bool> setup() async {
    if (_inited) return true;

    if (!await FC.init()) return false;

    await Tools.delay(seconds: 2);
    return _inited = true;
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
        'products': (context) => Products(),
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
