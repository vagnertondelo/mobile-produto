import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/loja_model.dart';

const String baseUrl = 'http://localhost:8080/loja';

class LojaService {
  final http.Client _client;

  LojaService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<LojaModel>> listar() async {
    final res = await _client.get(Uri.parse(baseUrl + '/listar'));
    if (res.statusCode >= 200 && res.statusCode < 300) {
      final data = jsonDecode(res.body) as List;
      return data.map((e) => LojaModel.fromJson(e)).toList();
    }
    throw Exception('Erro ao listar lojas: ${res.statusCode}');
  }
}
