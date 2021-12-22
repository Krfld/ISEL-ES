import 'package:flutter/material.dart';

import '../.imports.dart';

class Lists extends StatelessWidget {
  const Lists({Key? key}) : super(key: key);

  Future<void> _push(BuildContext context, GroupList list) async {
    Data.currentListId = list.id;
    await Navigator.pushNamed(context, 'Products');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Data.currentGroupId = null;
        return true;
      },
      child: StreamBuilder(
        stream: null, //Data.groupStream(Data.currentGroupId!),
        builder: (context, snapshot) {
          List<GroupList> lists = []; //Data.getGroupLists(Data.getGroup(Data.currentGroupId!));

          return Scaffold(
            appBar: AppBar(
              elevation: 4,
              title: Text('Data.getGroup(Data.currentGroupId!).name', style: TextStyle(fontSize: 24)),
              actions: [
                IconButton(
                  tooltip: 'Deleted',
                  icon: Icon(MdiIcons.trashCan),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => PopUp(title: 'Deleted'),
                  ),
                ),
                IconButton(
                  tooltip: 'Settings',
                  icon: Icon(MdiIcons.cog),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => PopUp(title: 'Settings'),
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
                    child: lists.isEmpty
                        ? Center(
                            child: Text(
                              'There are no shopping lists in this group\nCreate one',
                              style: TextStyle(fontSize: 14, color: Colors.black38),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(24),
                            physics: BouncingScrollPhysics(),
                            //separatorBuilder: (context, index) => Divider(thickness: 1),
                            itemCount: lists.length,
                            itemBuilder: (context, index) {
                              GroupList groupList = GroupList.fromMap(
                                  '', '', {}); //Data.getGroupList(Data.currentGroupId!, lists.elementAt(index).id);
                              return Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                  title: Text(groupList.name, style: TextStyle(fontSize: 20)),
                                  subtitle: Text(groupList.id, style: TextStyle(fontSize: 16)),
                                  trailing: IconButton(
                                    icon: Icon(MdiIcons.dotsHorizontal),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => PopUp(title: groupList.name),
                                    ),
                                  ),
                                  onTap: () {},
                                  //onLongPress: () => null,
                                ),
                              );
                            },
                          ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Center(
                      child: Button(
                        'Create\nList',
                        icon: MdiIcons.playlistPlus,
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => PopUp(title: 'Create List'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
