class Doador {
  String nome;
  String cpf;
  DateTime dataNascimento;
  String endereco;
  String numero;
  String complemento;
  String? telefone;
  String? email;
  String? senha;

  Doador({
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.endereco,
    required this.numero,
    required this.complemento,
    this.telefone,
    this.email,
    this.senha,
  });
  
}

