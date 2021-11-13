import 'package:flutter/material.dart';

import '../.imports.dart';

class Lists extends StatelessWidget {
  const Lists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
              elevation: 4,
              title: Text('Lists', style: TextStyle(fontSize: 24)),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(MdiIcons.arrowLeft),
                onPressed: () => app.msg('back'),
              ),
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
                          //elevation: 4,
                          //margin: EdgeInsets.symmetric(vertical: 8),
                          /*child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(id, style: TextStyle(fontSize: 16)),
                            ),*/
                        );
                      },
                    ), /*ListView(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(16),
                      children: [
                        for (var id in groups.groups)
                          ListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                            leading: null,
                            title: Text(id),
                            subtitle: Text(id),
                            trailing: IconButton(
                              icon: Icon(MdiIcons.dotsHorizontal),
                              onPressed: () => null,
                            ),
                            onTap: () => null,
                            //elevation: 4,
                            //margin: EdgeInsets.symmetric(vertical: 8),
                            /*child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(id, style: TextStyle(fontSize: 16)),
                            ),*/
                          ),
                      ],
                    ),*/
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.add_rounded),
                      label: Text('Create List'),
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        padding: EdgeInsets.all(16),
                        textStyle: TextStyle(fontSize: 16),
                        splashFactory: InkRipple.splashFactory,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
                      ),
                      onPressed: () => app.msg('create list'),
                    ),
                  ), /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.add_rounded),
                        label: Text('Create'),
                        style: ElevatedButton.styleFrom(
                          elevation: 4,
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
                          elevation: 4,
                          padding: EdgeInsets.all(16),
                          textStyle: TextStyle(fontSize: 16),
                          splashFactory: InkRipple.splashFactory,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
                        ),
                        onPressed: () => app.msg('join'),
                      ),
                    ],
                  ),*/
                )
              ],
            ),
          );
        });
  }
}
