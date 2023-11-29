import 'package:doa_conecta_app/doacao.dart';
import 'package:doa_conecta_app/pages/doador/firebase/doacao_firebase.dart';
import 'package:doa_conecta_app/pages/ongs/alerta.dart';
import 'package:doa_conecta_app/pages/ongs/firebase_ong/alerta_firebase.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecolherDoacaoPage extends StatefulWidget {
  final Donation donation;

  RecolherDoacaoPage({required this.donation});

  @override
  _RecolherDoacaoPageState createState() => _RecolherDoacaoPageState();
}
  
class _RecolherDoacaoPageState extends State<RecolherDoacaoPage> {
  final TextEditingController dataController = TextEditingController();
  final TextEditingController horarioController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  DateTime? dataRecolhimento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recolhimento de Doação'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: dataController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: 'Data de Recolhimento',
                hintText: 'DD/MM/AAAA',
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                var data = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2026, 1, 01),
                );
                if (data != null) {
                  final formattedDate = DateFormat('dd/MM/yyyy').format(data);
                  setState(() {
                    dataController.text = formattedDate;
                    dataRecolhimento = data;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: horarioController,
              decoration: InputDecoration(
                labelText: 'Horário de Recolhimento',
                hintText: 'HH:MM',
                prefixIcon: Icon(Icons.access_time),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                hintText: 'Descreva a doação a ser recolhida...',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String data = dataController.text;
                String horario = horarioController.text;
                String descricao = descricaoController.text;

                if (data.isNotEmpty && horario.isNotEmpty) {
                  // Obtendo o usuário autenticado atualmente
                  User? user = FirebaseAuth.instance.currentUser;
                  
                  if (user != null) {
                    String idOng = user.uid;
                    AlertaRecolhimento alerta = AlertaRecolhimento(
                      dataRecolhimento: dataRecolhimento ?? DateTime.now(),
                      horarioRecolhimento: horario,
                      descricao: descricao.isNotEmpty ? descricao : "", 
                      idDoacao: widget.donation.id,
                      idOng: idOng,
                    );

                    await enviarDadosRecolhimentoParaFirestore(alerta);
                    await adicionarDestinatario(widget.donation.id, idOng);
                    Navigator.pop(context);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Preencha todos os campos!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text('Enviar'),
              
              style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors
                .green), // Cor alterada para vermelho para melhor identificação
            minimumSize: MaterialStateProperty.all(const Size(200, 50)),
          ),
            ),
          ],
        ),
      ),
    );
  }
}
