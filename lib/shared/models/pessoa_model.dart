class Pessoa {
  final int id;
  final String nome_razao_social;
  final String? apelido_fantasia;
  final String cpf_cnpj;

  Pessoa(
    this.id, 
    this.nome_razao_social, 
    this.apelido_fantasia, 
    this.cpf_cnpj
  );

  Pessoa.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      nome_razao_social = json['nome_razao_social'],
      apelido_fantasia = json['apelido_fantasia'],
      cpf_cnpj = json['cpf_cnpj'];

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome_razao_social": nome_razao_social,
    "apelido_fantasia": apelido_fantasia,
    "cpf_cnpj": cpf_cnpj
  };

  static List<Pessoa> fromJsonList(List data) {
    return data.map((item) => Pessoa.fromJson(item)).toList();
  }
}
