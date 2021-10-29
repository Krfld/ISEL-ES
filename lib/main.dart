// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import './.imports.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routes: {
        'Home': (context) => Home(),
      },
      home: FutureBuilder(
        future: fb.setup(),
        builder: (context, snapshot) {
          return Home();
        },
      ),
    );
  }
}
