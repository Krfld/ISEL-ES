import 'package:flutter/material.dart';
import 'dart:async';

import '../imports.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ShoppingListsService.currentList = null;
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
                child: StreamBuilder<List<Product>>(
                  stream: null,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return SpinKitChasingDots(color: Colors.teal);
                    List<Product> products = snapshot.data!;

                    return products.isEmpty
                        ? Center(
                            child: Text(
                              'There are no products in this shopping list\nAdd some',
                              style: TextStyle(fontSize: 14, color: Colors.black38),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(24),
                            physics: BouncingScrollPhysics(),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              Product product = products.elementAt(index);
                              return Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                                  title: Text(product.name, style: TextStyle(fontSize: 20)),
                                  // subtitle: Text(product.id, style: TextStyle(fontSize: 16)),
                                  trailing: IconButton(
                                    icon: Icon(MdiIcons.dotsHorizontal),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => PopUp(title: Name(product.name)),
                                    ),
                                  ),
                                  // onTap: () => push(context, list),
                                ),
                              );
                            },
                          );
                  },
                ),
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
                    builder: (context) => PopUp(title: Text('Add Product')),
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
