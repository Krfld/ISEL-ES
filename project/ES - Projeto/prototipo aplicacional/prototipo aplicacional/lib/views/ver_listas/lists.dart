import 'package:flutter/material.dart';
import 'dart:async';

import '../../imports.dart';

class VerListas_Lists extends StatefulWidget {
  const VerListas_Lists({Key? key}) : super(key: key);

  @override
  State<VerListas_Lists> createState() => _VerListas_ListsState();
}

class _VerListas_ListsState extends State<VerListas_Lists> {
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();

    streamSubscription = ShoppingListsService.listsStream.listen((event) {
      ShoppingListsService.shoppingLists = event;
      ShoppingListsService.sinkCustomListsStream();
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        GroupsService.currentGroup = null; // Reset current group
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 4,
          title: StreamBuilder<void>(
              stream: GroupsService.customGroupsStream,
              builder: (context, snapshot) => Name(GroupsService.currentGroup.name, fontSize: 20)),
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
                  stream: ShoppingListsService.customListsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.active) {
                      // ShoppingListsService.sinkCustomListsStream();
                      return SpinKitChasingDots(color: Colors.teal);
                    }

                    return ShoppingListsService.shoppingLists.isEmpty
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
                            itemCount: ShoppingListsService.shoppingLists.length,
                            itemBuilder: (context, index) {
                              ShoppingList list = ShoppingListsService.shoppingLists.elementAt(index);
                              return Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                  title: Text(list.name, style: TextStyle(fontSize: 20)),
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
