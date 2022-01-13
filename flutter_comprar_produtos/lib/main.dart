import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;

import './imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        'Products': (context) => Products(),
        'Buying': (context) => Buying(),
      },
      home: Products(),
    );
  }
}
