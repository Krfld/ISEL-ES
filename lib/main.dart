import 'package:flutter/material.dart';
import './modules/firebase.dart';

import './.imports.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> init() async {
    if (!await FB.init()) {
      Log.print('Authentication failed');
      return false;
    }

    Data.init();

    await Tools.delay(seconds: 2);
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
      },
      home: FutureBuilder<bool>(
        future: init(),
        builder: (context, init) {
          return init.connectionState == ConnectionState.done && init.data! ? Groups() : LoadingScreen();
        },
      ),
    );
  }
}
