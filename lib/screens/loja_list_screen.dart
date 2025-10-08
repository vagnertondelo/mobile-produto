import 'package:app_produtos/controllers/loja_controller.dart';
import 'package:app_produtos/services/loja_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/menu_component.dart';

class LojaListScreen extends StatefulWidget {

  final controller = Get.put(LojaController(
    service: LojaService(),
  ));

  @override
  State<LojaListScreen> createState() => _LojaListScreenState();
}

class _LojaListScreenState extends State<LojaListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Lista Lojas"),
      ),
      drawer: MenuComponent(),
      body: Obx(() {
        if(widget.controller.isLoading.value){
          return Center(child: CircularProgressIndicator());
        }
        if(widget.controller.error.isNotEmpty){
          return Center(child: Text('Erro: ${widget.controller.error}'));
        }
        if(widget.controller.lojas.isEmpty){
          return Center(child: Text('Nenhuma loja encontrada'));
        }

        return ListView.builder(
          itemCount: widget.controller.lojas.length,
          itemBuilder: (context, i) {
            final loja = widget.controller.lojas[i];
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListTile(
                title: Text(loja.nome),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Endereço: ${loja.endereco}'),
                    Text('CNPJ: ${loja.cnpj}'),
                  ],
                ),
                trailing:
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/lojaForm', arguments: loja);
                      },
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        Get.defaultDialog(
                          title: "Remover",
                          middleText: 'Deseja remover a loja ${loja.nome}',
                          textCancel: "Cancelar",
                          textConfirm: "Confirmar",
                          onConfirm: (){
                            widget.controller.remover(loja.id);
                            Get.back();
                          },
                        );
                      },

                    ),
                  ],
                )

              ),
            );
          },
        );
      }),
    );
  }
}
