import 'package:flutter/material.dart';

import '../.imports.dart';

class Lists extends StatelessWidget {
  const Lists({Key? key}) : super(key: key);

  Future<void> _push(BuildContext context, GroupList list) async {
    Data.currentList = list;
    await Navigator.pushNamed(context, 'Lists');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Data.currentGroup = null;
        Log.print('Back');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: Text('Group Name', style: TextStyle(fontSize: 20)),
          //centerTitle: false,
          /*leading: IconButton(
            icon: Icon(MdiIcons.arrowLeft),
            onPressed: () => _back(context),
          ),*/
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              icon: Icon(MdiIcons.trashCan),
              onPressed: () => Log.print('trash'),
            ),
            IconButton(
              icon: Icon(MdiIcons.cog),
              onPressed: () => Log.print('settings'),
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
                  stream: Data.groupStream(Data.currentGroup!.id),
                  builder: (context, snapshot) {
                    List<GroupList> lists = Data.getGroupLists(Data.currentGroup!);
                    if (lists.isEmpty)
                      return Center(
                        child: Text(
                          'There are no shopping lists in this group\nCreate one',
                          style: TextStyle(color: Colors.black38),
                          textAlign: TextAlign.center,
                        ),
                      );
                    return ListView.builder(
                      padding: EdgeInsets.all(16),
                      physics: BouncingScrollPhysics(),
                      //separatorBuilder: (context, index) => Divider(thickness: 1),
                      itemCount: lists.length,
                      itemBuilder: (context, index) {
                        GroupList groupList = Data.getGroupList(Data.currentGroup!.id, lists.elementAt(index).id);
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                            title: Text(groupList.name, style: TextStyle(fontSize: 16)),
                            subtitle: Text(groupList.id, style: TextStyle(fontSize: 14)),
                            trailing: IconButton(
                              icon: Icon(MdiIcons.dotsHorizontal),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                    title: Text('List name'),
                                  );
                                },
                              ),
                            ),
                            onTap: () {},
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
              child: Center(
                child: Button(
                  'Create',
                  icon: MdiIcons.playlistPlus,
                  onPressed: () => Log.print('create list'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
