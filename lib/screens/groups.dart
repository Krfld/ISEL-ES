import 'package:flutter/material.dart';

import '../.imports.dart';

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*drawerEdgeDragWidth: 64,
      drawer: rawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Drawer Header')),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),*/
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
        elevation: 4,
        centerTitle: false,
        title: Text('Shopping List', style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.cog),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                title: Text('Settings'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListBody(
                      children: [
                        Text('Settings 1'),
                        Text('Settings 2'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Card(
              elevation: 4,
              margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              child: StreamBuilder(
                stream: Data.stream,
                builder: (context, snapshot) {
                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    physics: BouncingScrollPhysics(),
                    //separatorBuilder: (context, index) => Divider(thickness: 1),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      String id = 2.toString();
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                          title: Text(id, style: TextStyle(fontSize: 20)),
                          //subtitle: Text(id),
                          trailing: IconButton(
                            icon: Icon(MdiIcons.dotsHorizontal),
                            //splashRadius: 28,
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                  title: Text('Group name'),
                                );
                              },
                            ),
                          ),
                          onTap: () => Navigator.pushNamed(context, 'Lists'),
                          //onLongPress: () => null,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Button(
                  'Create',
                  icon: MdiIcons.accountMultiplePlus,
                  onPressed: () => Tools.print('create'),
                ),
                Button(
                  'Join',
                  icon: MdiIcons.accountGroup,
                  onPressed: () => Tools.print('join'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
