import 'package:flutter/material.dart';

import '../imports.dart';

export '../services/products_service.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

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
          title: Text('Use case - Buy products', style: TextStyle(fontSize: 24)),
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
