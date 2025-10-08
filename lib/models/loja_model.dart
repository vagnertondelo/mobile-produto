class LojaModel {
  final String id;
  final String nome;
  final String endereco;
  final String cnpj;

  LojaModel({
    required this.id,
    required this.nome,
    required this.endereco,
    required this.cnpj,
  });

  // Fábrica que cria um LojaModel a partir de um JSON
  factory LojaModel.fromJson(Map<String, dynamic> json) {
    return LojaModel(
      id: json['id']!.toString(),
      nome: json['nome'] ?? '',
      endereco: json['endereco'] ?? '',
      cnpj: json['cnpj'] ?? '',
    );
  }

  // Converter o objeto LojaModel para JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'endereco': endereco,
    'cnpj': cnpj,
  };
}
