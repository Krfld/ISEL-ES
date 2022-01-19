import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  void push(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        title: Text('Use cases', style: TextStyle(fontSize: 24)),
      ),
      body: Expanded(
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                title: Text('Comprar produtos'),
                onTap: () => push(context, 'ComprarProdutos_Products'),
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                title: Text('Criar grupo'),
                onTap: () => push(context, 'CriarGrupo_Groups'),
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                title: Text('Ver listas'),
                onTap: () => push(context, 'VerListas_Groups'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
