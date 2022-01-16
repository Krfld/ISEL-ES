import 'package:flutter/material.dart';

import '../imports.dart';

export '../services/products_service.dart';

class Buying extends StatelessWidget {
  const Buying({Key? key}) : super(key: key);

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

                List<Product> products = ProductsService.products
                    .where((product) =>
                        // Se foi comprado pelo próprio utilizador
                        (product.bought?.user ?? 'u1') == 'u1' &&
                        // Se foi comprado há menos de 24 horas
                        (!(product.bought?.timestamp!.add(Duration(hours: 24)).difference(DateTime.now()).isNegative ??
                            false)))
                    .toList();

                return products.isEmpty
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
