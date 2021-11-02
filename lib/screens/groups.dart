import 'package:flutter/material.dart';

import '../.imports.dart';

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        //elevation: 16,
        icon: Icon(Icons.add),
        label: Text('Add'),
        onPressed: () => null,
      ),
      appBar: AppBar(
        //elevation: 16,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => null,
        ),
        title: Text('Groups'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => null,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Card(
              elevation: 8,
              child: Center(
                child: Text('Bruh'),
              ), 
            ),
          ),
        ],
      ),
    );
  }
}
