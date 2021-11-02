import 'package:flutter/material.dart';

import '../.imports.dart';

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4,
        icon: Icon(Icons.add),
        label: Text('Add'),
        onPressed: () => app.msg('add'),
      ),
      appBar: AppBar(
        elevation: 4,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => app.msg('back'),
        ),
        title: Text('Groups'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => app.msg('settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              margin: EdgeInsets.all(16),
              elevation: 4,
              child: Center(
                child: Text('Bruh'),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
