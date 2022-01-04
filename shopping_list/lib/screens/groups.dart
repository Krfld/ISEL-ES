import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../imports.dart';

class Groups extends StatelessWidget {
  const Groups({Key? key}) : super(key: key);

  Future<void> push(BuildContext context, Group group) async {
    Data.currentGroup = group;
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
                builder: (context) => PopUp(title: 'Account'),
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
                child: StreamBuilder<List<Group>>(
                  stream: Data.getGroups(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return SpinKitChasingDots(color: Colors.teal);
                    List<Group> groups = snapshot.data!;
                    Log.print(groups);

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
                                  title: Text(group.name, style: TextStyle(fontSize: 24)),
                                  trailing: IconButton(
                                    icon: Icon(MdiIcons.dotsHorizontal),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => PopUp(title: group.name),
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
            // if(!Data.user.isGuest)
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
                      onPressed: () => showDialog(context: context, builder: (context) => CreateGroup()),
                    ),
                    Button(
                      'Join\nGroup',
                      icon: MdiIcons.accountGroup,
                      onPressed: () => showDialog(context: context, builder: (context) => JoinGroup()),
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

class CreateGroup extends StatelessWidget {
  CreateGroup({Key? key}) : super(key: key);

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopUp(
      title: 'Create Group',
      content: Form(
        key: form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Builder(
          builder: (context) {
            bool processing = false;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autofocus: true,
                  maxLength: 20,
                  keyboardType: TextInputType.name,
                  validator: (value) => value?.trim().isEmpty ?? true ? 'Invalid group name' : null,
                  decoration: InputDecoration(labelText: 'Group name'),
                  onSaved: (value) async {
                    if (processing || !form.currentState!.validate()) return;
                    processing = true;

                    await Data.createGroup(value!);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Group created')));
                    Navigator.pop(context);
                  },
                  onEditingComplete: () => form.currentState!.save(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class JoinGroup extends StatelessWidget {
  JoinGroup({Key? key}) : super(key: key);

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopUp(
      title: 'Join Group',
      content: Form(
        key: form,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Builder(
          builder: (context) {
            bool processing = false;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller,
                  autofocus: true,
                  maxLength: 20,
                  keyboardType: TextInputType.text,
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(' '))],
                  validator: (value) => value?.trim().isEmpty ?? true ? 'Invalid group ID' : null,
                  decoration: InputDecoration(labelText: 'Group ID'),
                  onSaved: (value) async {
                    if (processing || !form.currentState!.validate()) return;
                    processing = true;

                    if (!await Data.joinGroup(value!))
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Group doesn\'t exist')));
                    else
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Group joined')));

                    Navigator.pop(context);
                  },
                  onEditingComplete: () => form.currentState!.save(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                      child: Text('Join', textAlign: TextAlign.center),
                      style: ElevatedButton.styleFrom(elevation: 4),
                      onPressed: () => form.currentState!.save(),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
