import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../imports.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();

    streamSubscription = GroupsModel.firestoreGroupsStream.listen((event) {
      GroupsModel.groups = event;
      GroupsModel.sinkGroupsStream();
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();

    super.dispose();
  }

  Future<void> push(BuildContext context, Group group) async {
    GroupsModel.currentGroup = group;
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
        resizeToAvoidBottomInset: false,
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
                builder: (context) => PopUp(title: Text('Account')),
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
                  stream: GroupsModel.groupsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.active)
                      return SpinKitChasingDots(color: Colors.teal);

                    return GroupsModel.groups.isEmpty
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
                            itemCount: GroupsModel.groups.length,
                            itemBuilder: (context, index) {
                              Group group = GroupsModel.groups.elementAt(index);
                              return Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                  title: Name(group.name, fontSize: 24, alignment: Alignment.centerLeft),
                                  trailing: IconButton(
                                    icon: Icon(MdiIcons.dotsHorizontal),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => GroupSettings(groupId: group.id),
                                    ),
                                  ),
                                  onTap: () => push(context, group),
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ),
            // if(!GroupsLogic.user.isGuest)
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
                        builder: (context) => CreateGroup(),
                      ),
                    ),
                    Button(
                      'Join\nGroup',
                      icon: MdiIcons.accountGroup,
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => JoinGroup(),
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

// ----------------------------------------------------------------------------------------------------

class GroupSettings extends StatelessWidget {
  final String groupId;

  const GroupSettings({required this.groupId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> form = GlobalKey<FormState>();
    bool processing = false;

    return PopUp(
      title: StreamBuilder<void>(
        stream: GroupsModel.groupsStream,
        builder: (context, snapshot) => Name('Settings: ${GroupsModel.getGroup(groupId).name}'),
      ),
      content: Form(
        key: form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: GroupsModel.getGroup(groupId).name,
              maxLength: 20,
              keyboardType: TextInputType.name,
              validator: (value) => value?.trim().isEmpty ?? true ? 'Invalid group name' : null,
              decoration: InputDecoration(labelText: 'Group name'),
              onSaved: (value) async {
                if (processing || !form.currentState!.validate()) return;
                processing = true;

                if (value != GroupsModel.getGroup(groupId).name && await GroupsModel.updateGroup(groupId, value!))
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Group edited')));

                Navigator.pop(context);
              },
              onEditingComplete: () => form.currentState!.save(),
            ),
          ],
        ),
      ),
      actions: [
        PopUpButton(
          'Cancel',
          onPressed: () {
            if (processing) return;
            processing = true;

            Navigator.pop(context);
          },
        ),
        PopUpButton('Save', onPressed: () => form.currentState!.save()),
        /*PopUpButton(
          'Leave group',
          warning: true,
          onPressed: () => showDialog(
            context: context,
            builder: (context) => PopUp(
              title: 'Confirm',
            ),
          ),
        ),*/
      ],
    );
  }
}

// ----------------------------------------------------------------------------------------------------

class CreateGroup extends StatelessWidget {
  const CreateGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> form = GlobalKey<FormState>();

    bool processing = false;

    return PopUp(
      title: Text('Create Group'),
      content: Form(
        key: form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              maxLength: 20,
              keyboardType: TextInputType.name,
              validator: (value) => value?.trim().isEmpty ?? true ? 'Invalid group name' : null,
              decoration: InputDecoration(labelText: 'Group name'),
              onSaved: (value) async {
                if (processing || !form.currentState!.validate()) return;
                processing = true;

                await GroupsModel.createGroup(value!);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Group created')));
                Navigator.pop(context);
              },
              onEditingComplete: () => form.currentState!.save(),
            ),
          ],
        ),
      ),
      actions: [
        PopUpButton(
          'Cancel',
          onPressed: () {
            if (processing) return;
            processing = true;

            Navigator.pop(context);
          },
        ),
        PopUpButton('Create', onPressed: () => form.currentState!.save()),
      ],
    );
  }
}

// ----------------------------------------------------------------------------------------------------

class JoinGroup extends StatelessWidget {
  const JoinGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> form = GlobalKey<FormState>();
    final TextEditingController controller = TextEditingController();
    bool processing = false;

    return PopUp(
      title: Text('Join Group'),
      content: Form(
        key: form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller,
              maxLength: 20,
              keyboardType: TextInputType.text,
              inputFormatters: [FilteringTextInputFormatter.deny(RegExp(' '))],
              validator: (value) => value?.trim().isEmpty ?? true ? 'Invalid group ID' : null,
              decoration: InputDecoration(labelText: 'Group ID'),
              onSaved: (value) async {
                if (processing || !form.currentState!.validate()) return;
                processing = true;

                if (!await GroupsModel.joinGroup(value!))
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Group doesn\'t exist')));
                else
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Group joined')));

                Navigator.pop(context);
              },
              onEditingComplete: () => form.currentState!.save(),
            ),
          ],
        ),
      ),
      actions: [
        PopUpButton(
          'Cancel',
          onPressed: () {
            if (processing) return;
            processing = true;

            Navigator.pop(context);
          },
        ),
        PopUpButton('Join', onPressed: () => form.currentState!.save()),
      ],
    );
  }
}
