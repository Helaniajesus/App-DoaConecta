//-------------CLASSE DOACAO-----------------------//
import 'dart:core';

class Donation {
  final String codigo;
  final String categoria;
  final String nomeProduto;
  final String descricao;
  final String qualidade;
  final String tamanho;
  final String enderecoRetirada;
  final String fotos;
  final DateTime dataPublicacao;
  final DateTime dataRetirada;
  final bool status;
  final String destinatario;

  Donation(
    this.codigo,
    this.categoria,
    this.nomeProduto,
    this.descricao,
    this.qualidade,
    this.tamanho,
    this.enderecoRetirada,
    this.fotos,
    this.dataPublicacao,
    this.dataRetirada,
    this.status,
    this.destinatario
  );
}
