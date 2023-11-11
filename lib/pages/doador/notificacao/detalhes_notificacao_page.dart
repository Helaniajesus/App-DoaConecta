import 'package:doa_conecta_app/pages/doador/notificacao/notificacao.dart';
import 'package:flutter/material.dart';

class DetalhesNotificacaoPage extends StatelessWidget {
  final Notificacao notificacao;

  DetalhesNotificacaoPage({required this.notificacao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Notificação'),
        backgroundColor: Colors.green,
        centerTitle: true,
        leadingWidth: 100.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Mensagem: ${notificacao.descricao}'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('ONG: ${notificacao.ong}'),
          ),
          // Adicione mais detalhes conforme necessário
        ],
      ),
    );
  }
}
