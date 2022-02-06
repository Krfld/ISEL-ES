import 'package:flutter/material.dart';

import '../../imports.dart';

class ComprarProdutos_Buying extends StatelessWidget {
  const ComprarProdutos_Buying({Key? key}) : super(key: key);

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
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            child: StreamBuilder<void>(
              stream: ProductsService.customProductsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.active) {
                  ProductsService.sinkCustomProductsStream();
                  return SpinKitChasingDots(color: Colors.teal);
                }

                List<Product> products = ProductsService.buyingProducts;

                return products.isEmpty
                    ? Center(
                        child: Text(
                          'There are no products to buy',
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
