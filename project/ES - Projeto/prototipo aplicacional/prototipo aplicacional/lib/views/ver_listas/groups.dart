import 'package:flutter/material.dart';
import 'dart:async';

import '../../imports.dart';

// import '../imports.dart';

class VerListas_Groups extends StatefulWidget {
  const VerListas_Groups({Key? key}) : super(key: key);

  @override
  State<VerListas_Groups> createState() => _VerListas_GroupsState();
}

class _VerListas_GroupsState extends State<VerListas_Groups> {
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();

    streamSubscription = GroupsService.groupsStream.listen((event) {
      GroupsService.groups = event;
      GroupsService.sinkCustomGroupsStream();
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();

    super.dispose();
  }

  Future<void> push(BuildContext context, Group group) async {
    GroupsService.currentGroup = group; // Set current group
    await Navigator.pushNamed(context, 'VerListas_Lists');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 4,
          centerTitle: false,
          title: Text('Use case - Ver listas', style: TextStyle(fontSize: 24)),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                child: StreamBuilder<void>(
                  stream: GroupsService.customGroupsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.active) {
                      // GroupsService.sinkCustomGroupsStream();
                      return SpinKitChasingDots(color: Colors.teal);
                    }

                    return GroupsService.groups.isEmpty
                        ? Center(
                            child: Text(
                              'You\'re not in any shopping list group\nCreate or join one',
                              style: TextStyle(fontSize: 14, color: Colors.black38),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(24),
                            physics: BouncingScrollPhysics(),
                            itemCount: GroupsService.groups.length,
                            itemBuilder: (context, index) {
                              Group group = GroupsService.groups.elementAt(index);
                              return Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                  title: Name(group.name, fontSize: 24, alignment: Alignment.centerLeft),
                                  onTap: () => push(context, group),
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
