import 'package:flutter/material.dart';

import '../.imports.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () => Log.print('Click'),
          child: Text('Click'),
        ),
      ),
    );
  }
}