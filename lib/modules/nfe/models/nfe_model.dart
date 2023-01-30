import 'package:divina/shared/models/pessoa_model.dart';
import 'package:divina/modules/nfe/models/nfe_produto_model.dart';

class Nfe {
  final int id;
  final Pessoa emitente;
  final Pessoa destinatario;
  final String natureza_operacao;
  final String versao;
  final int numero;
  final int serie;
  final String chave;
  final String datahora_emissao;
  final double total_produto;
  final double total_frete;
  final double total_desconto;
  final double total_tributo;
  final double total;
  final String? observacao;
  final String? observacao_complementar;
  final List<NfeProduto?> nfe_produto;

  Nfe(
    this.id, 
    this.emitente,
    this.destinatario,
    this.natureza_operacao, 
    this.versao,
    this.numero, 
    this.serie, 
    this.chave, 
    this.datahora_emissao,
    this.total_produto,
    this.total_frete,
    this.total_desconto,
    this.total_tributo,
    this.total,
    this.observacao,
    this.observacao_complementar,
    this.nfe_produto
  );

  Nfe.fromJson(Map<String, dynamic> json) : 
    id = json['id'],
    emitente = Pessoa.fromJson(json['emitente']),
    destinatario = Pessoa.fromJson(json['destinatario']),
    natureza_operacao = json['natureza_operacao'],
    versao = json['versao'],
    numero = json['numero'],
    serie = json['serie'],
    chave = json['chave'],
    datahora_emissao = json['datahora_emissao'],
    total_produto = json['total_produto'] + .0,
    total_frete = json['total_frete'] + .0,
    total_desconto = json['total_desconto'] + .0,
    total_tributo = json['total_tributo'] + .0,
    total = json['total'] + .0,
    observacao = json['observacao'],
    observacao_complementar = json['observacao_complementar'],
    nfe_produto = NfeProduto.fromJsonList(json['nfe_produto']);

  Map<String, dynamic> toJson() => {
    "id": id,
    "emitente": emitente,
    "destinatario": destinatario,
    "natureza_operacao": natureza_operacao,
    "versao": versao,
    "numero": numero,
    "serie": serie,
    "chave": chave,
    "datahora_emissao": datahora_emissao,
    "total_produto": total_produto,
    "total_frete": total_frete,
    "total_desconto": total_desconto,
    "total_tributo": total_tributo,
    "total": total,
    "observacao": observacao,
    "observacao_complementar": observacao_complementar,
    "nfe_produto": nfe_produto 
  };

  static List<Nfe> fromJsonList(List data) {
    return data.map((item) => Nfe.fromJson(item)).toList();
  }
}
