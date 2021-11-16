import 'package:flutter/material.dart';

import '../.imports.dart';

class Lists extends StatelessWidget {
  const Lists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: Text('Group Name', style: TextStyle(fontSize: 20)),
        //centerTitle: false,
        leading: IconButton(
          icon: Icon(MdiIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.trashCan),
            onPressed: () => Tools.print('trash'),
          ),
          IconButton(
            icon: Icon(MdiIcons.cog),
            onPressed: () => Tools.print('settings'),
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                          title: Text(id, style: TextStyle(fontSize: 16)),
                          subtitle: Text(id, style: TextStyle(fontSize: 14)),
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
                          onTap: () => null,
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
                onPressed: () => Tools.print('create list'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
