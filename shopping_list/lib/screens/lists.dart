import 'dart:async';

import 'package:flutter/material.dart';

import '../imports.dart';

class Lists extends StatefulWidget {
  const Lists({Key? key}) : super(key: key);

  @override
  State<Lists> createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();

    streamSubscription = Data.firestoreListsStream.listen((event) {
      Data.lists = event;
      Data.sinkListsStream();
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();

    super.dispose();
  }

  Future<void> push(BuildContext context, ShoppingList list) async {
    Data.currentList = list;
    // await Navigator.pushNamed(context, 'Products');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        GroupsLogic.currentGroup = null;
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 4,
          title: StreamBuilder<void>(
              stream: GroupsLogic.groupsStream,
              builder: (context, snapshot) => Name(GroupsLogic.currentGroup.name, fontSize: 20)),
          actions: [
            IconButton(
              tooltip: 'Deleted',
              icon: Icon(MdiIcons.trashCan),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => PopUp(title: Text('Deleted')),
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
                child: StreamBuilder<void>(
                    stream: Data.listsStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.active)
                        return SpinKitChasingDots(color: Colors.teal);

                      return Data.lists.isEmpty
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
                              itemCount: Data.lists.length,
                              itemBuilder: (context, index) {
                                ShoppingList list = Data.lists.elementAt(index);
                                return Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                    title: Text(list.name, style: TextStyle(fontSize: 20)),
                                    // subtitle: Text(list.id, style: TextStyle(fontSize: 16)),
                                    trailing: IconButton(
                                      icon: Icon(MdiIcons.dotsHorizontal),
                                      onPressed: () => showDialog(
                                        context: context,
                                        builder: (context) => PopUp(title: Name(list.name)),
                                      ),
                                    ),
                                    onTap: () => push(context, list),
                                  ),
                                );
                              },
                            );
                    }),
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
                    onPressed: () => showDialog(context: context, builder: (context) => CreateList()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------------------------------------

class CreateList extends StatelessWidget {
  CreateList({Key? key}) : super(key: key);

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool processing = false;

    return PopUp(
      title: Text('Create List'),
      content: Form(
        key: form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autofocus: true,
              maxLength: 10,
              keyboardType: TextInputType.name,
              validator: (value) => value?.trim().isEmpty ?? true ? 'Invalid list name' : null,
              decoration: InputDecoration(labelText: 'List name'),
              onSaved: (value) async {
                if (processing || !form.currentState!.validate()) return;
                processing = true;

                await Data.createList(value!);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('List created')));
                Navigator.pop(context);
              },
              onEditingComplete: () => form.currentState!.save(),
            ),
            Divider(),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          child: Text('Cancel', textAlign: TextAlign.center),
          style: ElevatedButton.styleFrom(elevation: 4),
          onPressed: () {
            if (processing) return;
            processing = true;

            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: Text('Create', textAlign: TextAlign.center),
          style: ElevatedButton.styleFrom(elevation: 4),
          onPressed: () => form.currentState!.save(),
        ),
      ],
    );
  }
}
