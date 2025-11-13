import 'package:app_produtos/models/produto_model.dart';
import 'package:app_produtos/services/produto_service.dart';
import 'package:get/get.dart';

class ProdutoController extends GetxController{
  final ProdutoService service;
  ProdutoController({required this.service});

  final produtos = <ProdutoModel>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;

    @override
    void onInit(){
      super.onInit();
      listar();
    }

    Future<void> listar() async{
      try{
        isLoading.value = true;
        error.value = '';
        //Busca todos os produtos do serviço e atualiza a lista de forma reativa
        produtos.assignAll(await service.listar());
      }catch(e){
        error.value = e.toString();
      } finally{
        isLoading.value = false;
      }
    }
  Future<void> remover(String id) async{
    try{
      isLoading.value = true;
      final res = await service.delete(id);
      Get.snackbar('Sucesso', res);
      //forma 1
      listar();
      //forma 2
      // lojas.removeWhere((l)=>l.id == id);
    }catch(e){
      Get.snackbar('Erro', e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }
  Future<void> salvarOuEditar({
     String? id,
    required String nome,
    required String descricao,
    required double preco,
    String? lojaId}) async {
      try{
        isLoading.value = true;
        error.value = '';
        if(id == null){
          await service.salvar(
              ProdutoModel(
                  id:'',
                  nome: nome,
                  descricao: descricao,
                  preco: preco,
                  lojaId: lojaId)
          );
          Get.back();
          Get.snackbar('Sucesso', 'Produto salvao com sucesso');
          await this.listar();
        }else{
          await service.editar(
              ProdutoModel(
                  id: id,
                  nome: nome,
                  descricao: descricao,
                  preco: preco,
                  lojaId: lojaId)
          );
          Get.back();
          Get.snackbar('Sucesso', 'Produto editado com sucesso');
          await this.listar();
        }



      }catch (e){
        error.value = e.toString();
      } finally{
          isLoading.value = false;
      }
  }

}