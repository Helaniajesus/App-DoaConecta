class AlertaRecolhimento {
  final DateTime dataRecolhimento;
  final String horarioRecolhimento;
  final String? descricao;
  final String idDoacao;
  final String idOng;

  AlertaRecolhimento({
    required this.dataRecolhimento,
    required this.horarioRecolhimento,
    required this.descricao,
    required this.idDoacao,
    required this.idOng,
  });
}
