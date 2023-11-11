import 'package:doa_conecta_app/pages/doador/notificacao/detalhes_notificacao_page.dart';
import 'package:doa_conecta_app/pages/doador/notificacao/notificacao.dart';
import 'package:flutter/material.dart';

class NotificacoesPage extends StatelessWidget {
  final List<Notificacao> notificacoes = [
    Notificacao(
      ong: 'ONG A',
      data: DateTime(2023, 12, 11),
      horario: "15:30",
      descricao: '',
      numeroDoacao: 123,
      nomeItem: "Sofá",
    ),
    Notificacao(
      ong: 'ONG B',
      data: DateTime(2023, 11, 11),
      horario: "11:30",
      descricao: '',
      numeroDoacao: 234,
      nomeItem: "TV",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
          title: const Text("Notificações"),
          centerTitle: true,
          leadingWidth: 100.0,
      ),
      body: ListView.builder(
        itemCount: notificacoes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(15.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(20.0), // Ajuste o padding conforme necessário
              title: Text(
                "${notificacoes[index].ong} enviou uma proposta de recolhimento para a doação nº${notificacoes[index].numeroDoacao}",
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalhesNotificacaoPage(
                      notificacao: notificacoes[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
