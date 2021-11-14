import 'package:flutter/material.dart';

import '../.imports.dart';

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fb.stream,
        builder: (context, snapshot) {
          return Scaffold(
            drawerEdgeDragWidth: 64,
            drawer: Drawer(
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
            ),
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
              centerTitle: true,
              title: Text('Shopping List', style: TextStyle(fontSize: 24)),
              actions: [
                IconButton(
                  icon: Icon(MdiIcons.cog),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Settings'),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListBody(
                            children: [
                              Text('Settings'),
                              Text('Settings'),
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
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      physics: BouncingScrollPhysics(),
                      //separatorBuilder: (context, index) => Divider(thickness: 1),
                      itemCount: groups.groups.length,
                      itemBuilder: (context, index) {
                        String id = groups.groups.elementAt(index);
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                          child: ListTile(
                            minLeadingWidth: 32,
                            contentPadding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                            title: Text(id, style: TextStyle(fontSize: 24)),
                            //subtitle: Text(id),
                            trailing: IconButton(
                              icon: Icon(MdiIcons.dotsHorizontal),
                              onPressed: () => null,
                            ),
                            onTap: () => Navigator.pushNamed(context, 'Lists'),
                            //onLongPress: () => null,
                          ),
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
                        'Create\nGroup',
                        icon: MdiIcons.accountMultiplePlus,
                        onPressed: () => app.msg('create'),
                      ),
                      Button(
                        'Join\nGroup',
                        icon: MdiIcons.accountGroup,
                        onPressed: () => app.msg('join'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
