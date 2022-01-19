import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;

import './views/home.dart';

import './views/comprar_produtos/products.dart';
import './views/comprar_produtos/buying.dart';

import './views/criar_grupo/groups.dart';

import './views/ver_listas/groups.dart';
import './views/ver_listas/lists.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List - Protótipo aplicacional',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: {
        // Comprar produtos
        'ComprarProdutos_Products': (context) => ComprarProdutos_Products(),
        'ComprarProdutos_Buying': (context) => ComprarProdutos_Buying(),
        // Criar grupo
        'CriarGrupo_Groups': (context) => CriarGrupo_Groups(),
        // Ver listas
        'VerListas_Groups': (context) => VerListas_Groups(),
        'VerListas_Lists': (context) => VerListas_Lists(),
      },
      home: Home(),
    );
  }
}
