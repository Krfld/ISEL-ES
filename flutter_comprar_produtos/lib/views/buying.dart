import 'package:flutter/material.dart';
import 'dart:async';

import '../imports.dart';

export '../services/products_service.dart';

class Buying extends StatefulWidget {
  const Buying({Key? key}) : super(key: key);

  @override
  State<Buying> createState() => _BuyingState();
}

class _BuyingState extends State<Buying> {
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
    streamSubscription
        .cancel(); // Cancelar substricao para deixar de atualizar os valores quando volta para a janela anterior

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
          title: Text('List Name', style: TextStyle(fontSize: 24)),
        ),
        body: Center(
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            child: StreamBuilder<void>(
              stream: ProductsService.customProductsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) return SpinKitChasingDots(color: Colors.teal);

                return ProductsService.products.isEmpty
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
                        itemCount: ProductsService.products.length,
                        itemBuilder: (context, index) {
                          Product product = ProductsService.products.elementAt(index);
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                              title: Name(product.name, fontSize: 24, alignment: Alignment.centerLeft),
                              leading: Checkbox(
                                value: product.bought != null,
                                onChanged: (value) async {
                                  if (value!)
                                    await ProductsService.buyProduct(product);
                                  else
                                    await ProductsService.unbuyProduct(product);
                                },
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
