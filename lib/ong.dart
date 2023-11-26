class ONG {
  String nome;
  String cnpj;
  DateTime dataCriacao;
  //String cep;
  String endereco;
  String numero;
  String complemento;
  String? telefone;
  String? email;
  String? senha;
  String? fotoPerfil;

  ONG({
    required this.nome,
    required this.cnpj,
    required this.dataCriacao,
   // required this.cep,
    required this.endereco,
    required this.numero,
    required this.complemento,
    this.telefone,
    this.email,
    this.senha,
    this.fotoPerfil,
  });

   Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'cnpj': cnpj,
      'dataCriacao': dataCriacao.toIso8601String(), // Formatando a data como string
      'endereco': endereco,
      'numero': numero,
      'complemento': complemento,
      'telefone': telefone,
      'email': email,
      'senha': senha,
    };
  }
}





