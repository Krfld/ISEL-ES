import 'package:flutter/material.dart';

import '../.imports.dart';

class Lists extends StatelessWidget {
  const Lists({Key? key}) : super(key: key);

  Future<void> _push(BuildContext context, GroupList list) async {
    Data.currentList = list;
    await Navigator.pushNamed(context, 'Lists');
  }

  void _back(BuildContext context, {bool pop = false}) {
    Data.currentGroup = null;
    if (pop) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _back(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: Text('Group Name', style: TextStyle(fontSize: 20)),
          //centerTitle: false,
          leading: IconButton(
            icon: Icon(MdiIcons.arrowLeft),
            onPressed: () => _back(context, pop: true),
          ),
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
                    return ListView.builder(
                      padding: EdgeInsets.all(16),
                      physics: BouncingScrollPhysics(),
                      //separatorBuilder: (context, index) => Divider(thickness: 1),
                      itemCount: Data.getGroupLists(Data.currentGroup!).length,
                      itemBuilder: (context, index) {
                        GroupList groupList = Data.getGroupList(Data.currentGroup!.id, Data.currentList!.id);
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
