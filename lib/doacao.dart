//-------------CLASSE DOACAO-----------------------//
// ignore: unused_import
import 'dart:io';

class Donation {
  String id;
  final String categoria;
  final String nomeProduto;
  final String descricao;
  final String qualidade;
  final String tamanho;
  final String enderecoRetirada;
  List<String> fotosURLs;
  final DateTime dataPublicacao;
  final bool status;
  final String idONG;
  final String idDoador;

  Donation({
    required this.id,
    required this.categoria,
    required this.nomeProduto,
    required this.descricao,
    required this.qualidade,
    required this.tamanho,
    required this.enderecoRetirada,
    required this.fotosURLs,
    required this.dataPublicacao,
    required this.status,
    required this.idONG,
    required this.idDoador,
  });
}
