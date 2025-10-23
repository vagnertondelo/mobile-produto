import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/produto_model.dart';
const String baseUrl = 'http://localhost:8080/produtos';
class ProdutoService{

    final http.Client _client;
    ProdutoService({http.Client? client}) :
        _client = client ?? http.Client();

    Future<List<ProdutoModel>> listar() async{
      final res = await _client.get(Uri.parse(baseUrl + '/listar'));
      if(res.statusCode >= 200 && res.statusCode < 300 ){
            final data = jsonDecode(res.body) as List;
            return data.map((e) => ProdutoModel.fromJson(e)).toList();
      }
      throw Exception('Erro ao listar produtos: ${res.statusCode}');
    }

    Future<ProdutoModel> salvar(ProdutoModel produtoModel) async{
      final res = await _client.post(Uri.parse(baseUrl + '/salvar'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(produtoModel),
      );
      if(res.statusCode >= 200 && res.statusCode < 300 ){
        return ProdutoModel.fromJson(jsonDecode(res.body));
      }
      throw Exception('Erro ao apagar loja: ${res.statusCode}');
    }

    Future<String> delete(String id) async{
      // final res = await _client.post(_u('/apagar/$id'));
      final res = await _client.post(Uri.parse(baseUrl + '/apagar/$id'));
      if(res.statusCode >= 200 && res.statusCode < 300 ){
        return "Removido com sucesso";
      }
      throw Exception('Erro ao apagar loja: ${res.statusCode}');
    }


}