import 'package:flutter/material.dart';

import '../.imports.dart';

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

  Future<void> _push(BuildContext context, Group group) async {
    Data.currentGroup = group;
    await Navigator.pushNamed(context, 'Lists');
  }

  void _back(BuildContext context, {bool pop = false}) {
    if (pop) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
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
                  stream: Data.dataStream(),
                  builder: (context, snapshot) {
                    List<Group> groups = Data.getGroups();
                    if (groups.isEmpty)
                      return Center(
                        child: Text(
                          'You\'re not in a shopping list group\nCreate or join one',
                          style: TextStyle(color: Colors.black38),
                          textAlign: TextAlign.center,
                        ),
                      );
                    return ListView.builder(
                      padding: EdgeInsets.all(16),
                      physics: BouncingScrollPhysics(),
                      //separatorBuilder: (context, index) => Divider(thickness: 1),
                      itemCount: groups.length,
                      itemBuilder: (context, index) {
                        Group group = groups.elementAt(index);
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                            title: Text(group.name, style: TextStyle(fontSize: 20)),
                            //subtitle: Text(group.name),
                            trailing: IconButton(
                              icon: Icon(MdiIcons.dotsHorizontal),
                              //splashRadius: 28,
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                  title: Text(group.name),
                                ),
                              ),
                            ),
                            onTap: () => _push(context, group),
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
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                        title: Text('Create Group'),
                      ),
                    ),
                  ),
                  Button(
                    'Join',
                    icon: MdiIcons.accountGroup,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                        title: Text('Join Group'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
