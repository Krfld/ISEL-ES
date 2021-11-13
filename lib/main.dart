import 'package:flutter/material.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.teal,
        //brightness: Brightness.dark,
      ),
      routes: {
        'Home': (context) => Home(),
        'Groups': (context) => Groups(),
      },
      home: FutureBuilder(
        future: fb.init(),
        builder: (context, setup) {
          return setup.connectionState == ConnectionState.done ? Groups() : LoadingScreen();
        },
      ),
    );
  }
}
