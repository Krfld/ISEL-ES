import 'package:flutter/material.dart';

import '../.imports.dart';

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: fb.stream,
        builder: (context, snapshot) {
          return Scaffold(
            /*floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.all(16),
            child: FloatingActionButton(
              child: Icon(Icons.add_rounded, size: 32),
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(64))),
              onPressed: () => null,
            ),
          ),*/
            appBar: AppBar(
              elevation: 8,
              title: Text('Groups', style: TextStyle(fontSize: 24)),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () => app.msg('back'),
              ),
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
                    elevation: 8,
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      children: [
                        for (var id in groups.groups)
                          Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(id, style: TextStyle(fontSize: 16)),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.add_rounded),
                        label: Text('Create'),
                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          padding: EdgeInsets.all(16),
                          textStyle: TextStyle(fontSize: 16),
                          splashFactory: InkRipple.splashFactory,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
                        ),
                        onPressed: () => app.msg('create'),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.arrow_upward_rounded),
                        label: Text('Join'),
                        style: ElevatedButton.styleFrom(
                          elevation: 8,
                          padding: EdgeInsets.all(16),
                          textStyle: TextStyle(fontSize: 16),
                          splashFactory: InkRipple.splashFactory,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
                        ),
                        onPressed: () => app.msg('join'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
