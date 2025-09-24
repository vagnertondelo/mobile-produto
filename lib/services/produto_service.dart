import 'package:http/http.dart' as http;
const String baseUrl = 'http://localhost:8080/produtos';
class ProdutoService{

    final http.Client _client;
    ProdutoService({http.Client? client}) :
        _client = client ?? http.Client();

    Future<List<ProdutoModel>> buscar() async{
      // final res = await _client.get(_u('/listar'));
      final res = await _client.get(Uri.parse(baseUrl + '/listar'));
      if(res.statusCode == 200 ){

      }

    }


}