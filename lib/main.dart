import 'package:flutter/material.dart';
import '../modules/firebase.dart';

import './.imports.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: FutureBuilder(
        future: FB.init(),
        builder: (context, setup) {
          return setup.connectionState == ConnectionState.done ? Groups() : LoadingScreen();
        },
      ),
    );
  }
}
