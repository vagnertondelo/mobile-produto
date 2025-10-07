import 'package:app_produtos/controllers/produto_controller.dart';
import 'package:app_produtos/services/produto_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/menu_component.dart';

class ProdutoListScreen extends StatefulWidget {

  final controller = Get.put(ProdutoController(
                          service: ProdutoService()));

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
      body:
        Obx(() {
            if(widget.controller.isLoading.value){
              return Center(child: CircularProgressIndicator(),);
            }
            if(widget.controller.error.isNotEmpty){
                return Center(child:
                Text('Erro: ${widget.controller.error}'),);
            }
            if(widget.controller.produtos.isEmpty){
              return Center(child: Text('Nenhum produto encontrado'),);
            }

            return ListView.builder(
                itemCount: widget.controller.produtos.length,
                itemBuilder: (variavel, i){
                  final p = widget.controller.produtos[i];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      title: Text('${p.nome} - R\$ ${p.preco.toStringAsFixed(2)}'),
                      subtitle: Text(p.descricao),
                      trailing: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.delete, color: Colors.red,)),
                    ),
                  );
                }
            );
        })
    );
  }
}
