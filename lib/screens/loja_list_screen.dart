import 'package:app_produtos/controllers/loja_controller.dart';
import 'package:app_produtos/services/loja_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/menu_component.dart';

class LojaListScreen extends StatefulWidget {

  // final controller = Get.put(LojaController(
  //   service: LojaService(),
  // ));

  @override
  State<LojaListScreen> createState() => _LojaListScreenState();
}

class _LojaListScreenState extends State<LojaListScreen> {
  final LojaController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Lista Lojas"),
      ),
      drawer: MenuComponent(),
      body: Obx(() {
        if(controller.isLoading.value){
          return Center(child: CircularProgressIndicator());
        }
        if(controller.error.isNotEmpty){
          return Center(child: Text('Erro: ${controller.error}'));
        }
        if(controller.lojas.isEmpty){
          return Center(child: Text('Nenhuma loja encontrada'));
        }

        return ListView.builder(
          itemCount: controller.lojas.length,
          itemBuilder: (context, i) {
            final loja = controller.lojas[i];
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
                            controller.remover(loja.id);
                            Get.back();
                          },
                        );
                      },

                    ),
                  ],
                ),
                onTap: (){


                 },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Get.toNamed('/lojaForm');
          },
        label: Text('Nova loja'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
