class NfeProduto {
  final int id;
  final int item;
  final String codigo;
  final String descricao;
  final double total;
  final double quantidade;
  final double valor_unitario;

  NfeProduto(
    this.id, 
    this.item, 
    this.codigo, 
    this.descricao,
    this.total,
    this.quantidade,
    this.valor_unitario
  );

  NfeProduto.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      item = json['item'],
      codigo = json['codigo'],
      descricao = json['descricao'],
      total = json['total'] + .0,
      quantidade = json['quantidade'] + .0,
      valor_unitario = json['valor_unitario'] + .0;

  Map<String, dynamic> toJson() => {
    "id": id,
    "item": item,
    "codigo": codigo,
    "descricao": descricao,
    "total": total
  };

  static List<NfeProduto> fromJsonList(List data) {
    return data.map((item) => NfeProduto.fromJson(item)).toList();
  }
}
