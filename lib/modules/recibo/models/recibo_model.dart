import 'package:divina/shared/models/pessoa_model.dart';
import 'package:divina/modules/recibo/models/recibo_produto_model.dart';

class Recibo {
  final int id;
  final Pessoa emitente;
  final Pessoa destinatario;
  final int numero;
  final String? serie;
  final String datahora_emissao;
  final double total;
  final String? observacao;
  final List<ReciboProduto?> recibo_produto;

  Recibo(
    this.id, 
    this.emitente,
    this.destinatario,
    this.numero, 
    this.serie, 
    this.total,
    this.datahora_emissao,
    this.observacao,
    this.recibo_produto
  );

  Recibo.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      emitente = Pessoa.fromJson(json['emitente']),
      destinatario = Pessoa.fromJson(json['destinatario']),
      numero = json['numero'],
      serie = json['serie'],
      datahora_emissao = json['datahora_emissao'],
      total = json['total'] + .0,
      observacao = json['observacao'],
      recibo_produto = [];

  Map<String, dynamic> toJson() => {
    "id": id,
    "numero": numero,
    "serie": serie,
    "datahora_emissao": datahora_emissao,
    "total": total,
    "observacao": observacao,
    "recibo_produto": recibo_produto
  };

  static List<Recibo> fromJsonList(List data) {
    return data.map((item) => Recibo.fromJson(item)).toList();
  }
}
