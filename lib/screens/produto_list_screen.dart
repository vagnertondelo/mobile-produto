import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/menu_component.dart';

class ProdutoListScreen extends StatefulWidget {
  @override
  State<ProdutoListScreen> createState() => _ProdutoListScreenState();
}
class _ProdutoListScreenState extends State<ProdutoListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Lista Produtos"),
      ),
      drawer:
      MenuComponent(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Tela produtos'),
          ],
        ),
      ),
    );
  }
}
