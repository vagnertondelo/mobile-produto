import 'package:app_produtos/controllers/loja_controller.dart';
import 'package:app_produtos/models/loja_model.dart';
import 'package:app_produtos/services/loja_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/menu_component.dart';

class LojaFormScreen extends StatefulWidget {

  final controller = Get.put(LojaController(
    service: LojaService(),
  ));

  @override
  State<LojaFormScreen> createState() => _LojaFormScreenState();
}

class _LojaFormScreenState extends State<LojaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _enderecoCtrl = TextEditingController();
  final _cnpjCtrl = TextEditingController();

  String? id;
  @override
  void initState(){
    super.initState();
    final arg = Get.arguments;
    if(arg !=null && arg is LojaModel){
      id = arg.id;
      _nomeCtrl.text = arg.nome;
      _enderecoCtrl.text = arg.endereco;
      _cnpjCtrl.text = arg.cnpj;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Form Lojas"),
      ),
      drawer: MenuComponent(),
      body:
          Padding(padding: EdgeInsets.all(16),
            child: Form(
              child:
              ListView(
                children: [
                  TextFormField(
                    controller: _nomeCtrl,
                    decoration: InputDecoration(labelText: 'NOme da loja')
                  ),
                  TextFormField(
                      controller: _enderecoCtrl,
                      decoration: InputDecoration(labelText: 'Endereço da loja')
                  ),
                  TextFormField(
                      controller: _cnpjCtrl,
                      decoration: InputDecoration(labelText: 'CNPJ da loja')
                  ),
                ],
              )
            ),
          ),


    );
  }
}
