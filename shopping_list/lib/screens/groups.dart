import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_list/cf_dummy.dart';

import '../imports.dart';

class Groups extends StatefulWidget {
  const Groups({Key? key}) : super(key: key);

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _push(BuildContext context, Group group) async {
    Data.currentGroup = group;
    await Navigator.pushNamed(context, 'Lists');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Data.currentGroup = null;
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
                            //separatorBuilder: (context, index) => Divider(thickness: 1),
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
                                  onTap: () => _push(context, group),
                                  //onLongPress: () => null,
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
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => PopUp(
                          title: 'Create Group',
                          content: Form(
                            key: _formKey,
                            onChanged: () => Log.print('Form changed'),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  maxLength: 20,
                                  validator: (value) =>
                                      value?.isEmpty ?? true ? 'The group name can\'t be empty' : null,
                                  decoration: InputDecoration(
                                    hintText: 'Group name',
                                    // labelText: 'Group name',
                                  ),
                                  onChanged: (value) => Log.print('Changed: \'$value\''),
                                  onFieldSubmitted: (value) => Log.print('Field submitted: \'$value\''),
                                  onSaved: (value) => Log.print('Saved: \'$value\''),
                                  onEditingComplete: () => Log.print('Editing complete'),
                                ),
                                ElevatedButton(
                                  child: Text('Create'),
                                  onPressed: () {
                                    // _formKey.currentState!.save();
                                    _formKey.currentState!.validate();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Button('Join\nGroup', icon: MdiIcons.accountGroup, onPressed: () {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bruh')));
                      showDialog(
                        context: context,
                        builder: (context) => PopUp(title: 'Join Group'),
                      );
                    }),
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
