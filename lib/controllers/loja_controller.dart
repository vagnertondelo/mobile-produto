import 'package:app_produtos/models/loja_model.dart';
import 'package:app_produtos/services/loja_service.dart';
import 'package:get/get.dart';

class LojaController extends GetxController {
  final LojaService service;
  LojaController({required this.service});

  final lojas = <LojaModel>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    listar();
  }

  Future<void> listar() async {
    try {
      isLoading.value = true;
      error.value = '';
      // Busca todas as lojas do serviço e atualiza a lista de forma reativa
      lojas.assignAll(await service.listar());
    } catch (e) {
      error.value = e.toString();
    } finally {
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


}
