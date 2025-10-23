class ProdutoModel {
    final String id;
    final String nome;
    final String descricao;
    final double preco;
    final String? lojaId;

    ProdutoModel({
        required this.id,
        required this.nome,
        required this.descricao,
        required this.preco,
        this.lojaId
    });

    // Fabrica que cruia um Produto model a partir de um JSON
    factory ProdutoModel.fromJson(Map<String, dynamic> json){
      return ProdutoModel(
        id: json['id']!.toString(),
        nome: json['nome'] ?? '',
        descricao: json['descricao'] ?? '',
        preco: (json['preco'] is num)
            ? (json['preco'] as num).toDouble()
            : double.tryParse(json['preco']?.toString() ?? '0') ?? 0.0,
        lojaId: json['lojaId'] ?? ''
      );
    }

    //COnverter o objeto Produto model para JSON
  Map<String, dynamic> toJson() => {
      'id': id,
    'nome': nome,
    'descricao': descricao,
    'preco':preco,
    'lojaId': lojaId
  };
}