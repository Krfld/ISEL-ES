import 'package:flutter/material.dart';
import 'dart:async';

import '../../imports.dart';

class CriarGrupo_Groups extends StatefulWidget {
  const CriarGrupo_Groups({Key? key}) : super(key: key);

  @override
  State<CriarGrupo_Groups> createState() => _CriarGrupo_GroupsState();
}

class _CriarGrupo_GroupsState extends State<CriarGrupo_Groups> {
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
          title: Text('Use case - Criar grupo', style: TextStyle(fontSize: 24)),
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

                    List<Group> groups = GroupsService.groups;

                    return groups.isEmpty
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
                            itemCount: groups.length,
                            itemBuilder: (context, index) {
                              Group group = groups.elementAt(index);
                              return Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                  title: Name(group.name, fontSize: 24, alignment: Alignment.centerLeft),
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
              child: Center(
                child: Button(
                  'Create\nGroup',
                  icon: Icons.add,
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => CreateGroup(),
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
              onEditingComplete: () => form.currentState!.save(),
              onSaved: (value) async {
                if (processing || !form.currentState!.validate()) return;
                processing = true;

                await GroupsService.createGroup(value!);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Group created')));
                Navigator.pop(context);
              },
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
