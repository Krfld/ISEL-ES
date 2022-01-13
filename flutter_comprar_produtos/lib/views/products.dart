import 'package:flutter/material.dart';
import 'dart:async';

import '../imports.dart';

export '../services/products_service.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // ShoppingListsService.currentShoppingList = null;
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
        body: Center(
          child: Button(
            'Buy\nproducts',
            icon: MdiIcons.playlistPlus,
            onPressed: () => Navigator.pushNamed(context, 'Buying'),
          ),
        ),
      ),
    );
  }
}
