import 'package:flutter/material.dart';
import './modules/firebase.dart';

import './.imports.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static bool _inited = false;

  Future<bool> init() async {
    if (_inited) return true;

    if (!await FC.init()) {
      Log.print('Authentication failed');
      return false;
    }

    // await Data.init();

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
        future: init(),
        builder: (context, init) {
          return init.connectionState == ConnectionState.done && init.hasData && init.data!
              ? Groups()
              : LoadingScreen();
        },
      ),
    );
  }
}
