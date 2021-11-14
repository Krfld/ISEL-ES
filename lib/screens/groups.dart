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
            drawerEdgeDragWidth: 32,
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
              title: Text('Shopping List', style: TextStyle(fontSize: 24)),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(MdiIcons.cog),
                  onPressed: () => app.msg('settings'),
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
                    child: ListView.separated(
                      padding: EdgeInsets.all(16),
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => Divider(thickness: 1),
                      itemCount: groups.groups.length,
                      itemBuilder: (context, index) {
                        String id = groups.groups.elementAt(index);
                        return ListTile(
                          minLeadingWidth: 32,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                          leading: null,
                          title: Text(id),
                          subtitle: Text(id),
                          trailing: IconButton(
                            icon: Icon(MdiIcons.dotsHorizontal),
                            onPressed: () => null,
                          ),
                          onTap: () => null,
                          onLongPress: () => null,
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
                        icon: MdiIcons.accountMultiplePlus,
                        onPressed: () => Navigator.pushNamed(context, 'Lists'),
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
