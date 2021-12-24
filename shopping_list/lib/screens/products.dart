import 'package:flutter/material.dart';

import '../imports.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Data.currentList = null;
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 4,
          title: Text('List Name', style: TextStyle(fontSize: 24)),
          actions: [
            IconButton(
              tooltip: 'Settings',
              icon: Icon(MdiIcons.cog),
              onPressed: () => Log.print('settings'),
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
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Button(
                  'Add\nProduct',
                  icon: MdiIcons.playlistPlus,
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => PopUp(title: 'Add Product'),
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
