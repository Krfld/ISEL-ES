import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../.imports.dart';

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

  Future<void> _push(BuildContext context, Group group) async {
    Data.currentGroupId = group.id;
    await Navigator.pushNamed(context, 'Lists');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
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
              tooltip: 'Account',
              icon: Icon(MdiIcons.account),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => PopUp(title: 'Account'),
              ),
            ),
            IconButton(
              tooltip: 'Settings',
              icon: Icon(MdiIcons.cog),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => PopUp(
                  title: 'Settings',
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListBody(
                        children: [
                          Text('Settings 1'),
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
                margin: EdgeInsets.all(24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                child: StreamBuilder(
                  stream: Data.dataStream(),
                  builder: (context, snapshot) {
                    List<Group> groups = Data.getGroups();

                    return groups.isEmpty
                        ? Center(
                            child: Text(
                              'You\'re not in a shopping list group\nCreate or join one',
                              style: TextStyle(color: Colors.black38),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(24),
                            physics: BouncingScrollPhysics(),
                            //separatorBuilder: (context, index) => Divider(thickness: 1),
                            itemCount: groups.length,
                            itemBuilder: (context, index) {
                              Group group = groups.elementAt(index);
                              return Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                  title: Text(group.name, style: TextStyle(fontSize: 20)),
                                  trailing: IconButton(
                                    icon: Icon(MdiIcons.dotsHorizontal),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => PopUp(title: group.name),
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
              child: Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(
                      'Create\nGroup',
                      icon: MdiIcons.accountMultiplePlus,
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => PopUp(title: 'Create Group'),
                      ),
                    ),
                    Button(
                      'Join\nGroup',
                      icon: MdiIcons.accountGroup,
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => PopUp(title: 'Join Group'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
