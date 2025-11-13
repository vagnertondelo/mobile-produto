import 'package:app_produtos/controllers/loja_controller.dart';
import 'package:app_produtos/controllers/produto_controller.dart';
import 'package:app_produtos/models/loja_model.dart';
import 'package:app_produtos/models/produto_model.dart';
import 'package:app_produtos/services/loja_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/menu_component.dart';

class ProdutoFormScreen extends StatefulWidget {

  @override
  State<ProdutoFormScreen> createState() => _ProdutoFormScreenState();
}

class _ProdutoFormScreenState extends State<ProdutoFormScreen> {

  final produtoController =  Get.find<ProdutoController>();
  final lojaController =  Get.find<LojaController>();
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _descricaoCtrl = TextEditingController();
  final _precoCtrl = TextEditingController();

  String? id;
  String? _lojaId;
  @override
  void initState(){
    super.initState();
    final arg = Get.arguments;
    if(arg !=null && arg is ProdutoModel){
      id = arg.id;
      _nomeCtrl.text = arg.nome;
      _descricaoCtrl.text = arg.descricao;
      _precoCtrl.text = arg.preco.toString();

      if(lojaController.lojas.isEmpty){
        lojaController.listar();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Form Produtos"),
      ),
      drawer: MenuComponent(),
      body:
      Padding(padding: EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child:
            ListView(
              children: [
                TextFormField(
                    controller: _nomeCtrl,
                    decoration: InputDecoration(labelText: 'Nome do Produto')
                ),
                TextFormField(
                    controller: _descricaoCtrl,
                    decoration: InputDecoration(labelText: 'Descrição')
                ),
                TextFormField(
                    controller: _precoCtrl,
                    decoration: InputDecoration(labelText: 'Preço')
                ),
                SizedBox(height: 20,),
                Obx((){
                  //Carregando lojas
                  if(lojaController.isLoading.value){
                    return LinearProgressIndicator();
                  }
                  final lojas = lojaController.lojas;

                  // Opções do dropdown
                final items =  lojas.map((l){
                    return DropdownMenuItem<String>(
                      value: l.id,
                      child: Text('${l.nome}'),
                    );
                  }).toList();
                //Sem lojas cadastradas
                  if(items.isEmpty){
                    return InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Loja',
                          border: OutlineInputBorder(),
                        ),
                        child: Text('Nenhum loja encontrada'),
                    );
                  }

                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Loja',
                      border: OutlineInputBorder(),
                    ),
                    items: items,
                    onChanged: (v) {
                        setState(() {
                            _lojaId = v;
                        });
                    },
                  );
                }),
                SizedBox(height: 20,),
                Obx(() => ElevatedButton.icon(
                  onPressed:
                  produtoController.isLoading.value ? null
                      :(){
                    if(_formKey.currentState!.validate()){
                      final precoConvertido = double.parse(_precoCtrl.text);
                      produtoController.salvarOuEditar(
                          id: id,
                          nome: _nomeCtrl.text,
                          descricao: _descricaoCtrl.text,
                          preco: precoConvertido,
                          lojaId: _lojaId
                      );
                    }
                  },
                  icon: Icon(Icons.save),
                  label: Text(
                      produtoController.isLoading.value ? 'Salvando...': 'Salvar'
                  ),
                )

                )
              ],
            )
        ),
      ),


    );
  }
}
