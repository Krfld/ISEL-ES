import 'package:flutter/material.dart';
import 'dart:async';

import '../imports.dart';

export '../services/products_service.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();

    // Subscreve às atualizacoes dos produtos e atualiza-os
    streamSubscription = ProductsService.productsStream.listen((event) {
      ProductsService.products = event;
      ProductsService.sinkCustomProductsStream();
    });
  }

  @override
  void dispose() {
    // Cancelar substricao para deixar de atualizar os valores quando volta para a janela anterior
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
