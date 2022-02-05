import 'package:flutter/material.dart';
import 'dart:async';

import '../../imports.dart';

class ComprarProdutos_Products extends StatefulWidget {
  const ComprarProdutos_Products({Key? key}) : super(key: key);

  @override
  State<ComprarProdutos_Products> createState() => _ComprarProdutos_ProductsState();
}

class _ComprarProdutos_ProductsState extends State<ComprarProdutos_Products> {
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
          title: Text('Use case - Comprar produtos', style: TextStyle(fontSize: 24)),
        ),
        body: Center(
          child: Button(
            'Buy\nproducts',
            icon: Icons.add,
            onPressed: () => Navigator.pushNamed(context, 'ComprarProdutos_Buying'),
          ),
        ),
      ),
    );
  }
}
