import 'package:flutter/material.dart';

import '../.imports.dart';

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4,
        icon: Icon(Icons.add),
        label: Text('Add'),
        onPressed: () => app.msg('add'),
      ),*/
      appBar: AppBar(
        elevation: 4,
        title: Text('Groups'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          //tooltip: 'Go back',
          onPressed: () => app.msg('back'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            //tooltip: 'Settings',
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.arrow_downward_rounded),
                  label: Text('Join'),
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    splashFactory: InkRipple.splashFactory,
                  ),
                  onPressed: () => app.msg('Join'),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.add_rounded),
                  label: Text('Create'),
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                    splashFactory: InkRipple.splashFactory,
                  ),
                  onPressed: () => app.msg('Create'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
