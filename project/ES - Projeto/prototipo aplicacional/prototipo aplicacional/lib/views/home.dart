import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        title: Text('Use cases', style: TextStyle(fontSize: 24)),
      ),
      body: Column(
        children: [
          Card(
            elevation: 4,
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              title: Text('Comprar produtos'),
              onTap: () =>
                  Navigator.pushNamed(context, 'ComprarProdutos_Products'), // Trasnsitar para a tela de produtos
            ),
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              title: Text('Ver listas'),
              onTap: () => Navigator.pushNamed(context, 'VerListas_Groups'), // Trasnsitar para a tela de listas
            ),
          ),
          Card(
            elevation: 4,
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
              title: Text('Criar grupo'),
              onTap: () => Navigator.pushNamed(context, 'CriarGrupo_Groups'), // Trasnsitar para a tela de criar grupo
            ),
          ),
        ],
      ),
    );
  }
}
