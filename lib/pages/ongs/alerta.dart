import 'package:cloud_firestore/cloud_firestore.dart';

class AlertaRecolhimento {
  final DateTime dataRecolhimento;
  final String horarioRecolhimento;
  final String? descricao;
  final bool status;
  final bool aceite;
  final String idDoacao;
  final String idOng;

  AlertaRecolhimento({
    required this.dataRecolhimento,
    required this.horarioRecolhimento,
    required this.descricao,
    required this.status,
    required this.aceite,
    required this.idDoacao,
    required this.idOng,
  });

 factory AlertaRecolhimento.fromMap(Map<String, dynamic> map) {
    return AlertaRecolhimento(
      idDoacao: map['idDoacao'],
      idOng: map['idOng'],
      status: map['status'] ?? false,
      aceite: map['aceite'] ?? false,
      horarioRecolhimento: map['horario'] ?? '',
      dataRecolhimento: (map['dataRecolhimento'] as Timestamp).toDate(),
      descricao: map['descricao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idDoacao': idDoacao,
      'idOng': idOng,
      'status': status,
      'aceite': aceite,
      'horarioRecolhimento': horarioRecolhimento,
      'dataRecolhimento': dataRecolhimento,
      'descricao': descricao,
    };
  }
}