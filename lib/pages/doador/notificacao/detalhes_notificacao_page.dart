import 'package:doa_conecta_app/pages/ongs/alerta.dart';
import 'package:doa_conecta_app/pages/ongs/firebase_ong/alerta_firebase.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AlertDetailsPage extends StatefulWidget {
  final Map<String, dynamic> alertDetails;

  AlertDetailsPage({Key? key, required this.alertDetails}) : super(key: key);

  @override
  _AlertDetailsPageState createState() => _AlertDetailsPageState();
}

class _AlertDetailsPageState extends State<AlertDetailsPage> {
  late String ongName;
  late String productName;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    ongName = await _getOngName(widget.alertDetails['idOng']);
    productName = await _getProductName(widget.alertDetails['idDoacao']);
    setState(() {}); // Atualiza o estado para refletir as novas informações
  }


  Future<String> _getOngName(String ongId) async {
    DocumentSnapshot ongDoc =
        await _firestore.collection('ong').doc(ongId).get();
    return ongDoc['nome'] ?? 'Nome da ONG não encontrado';
  }

  Future<String> _getProductName(String donationId) async {
    DocumentSnapshot donationDoc =
        await _firestore.collection('doacao').doc(donationId).get();
    return donationDoc['nomeProduto'] ?? 'Nome do Produto não encontrado';
  }

  @override
  Widget build(BuildContext context) {
    bool isAlarmActive = widget.alertDetails['status'] ==
        false; // Defina a lógica para verificar o status do alarme
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Detalhes do Alerta'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                FutureBuilder<String>(
                  future: _getOngName(widget.alertDetails['idOng']),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Erro ao carregar o nome da ONG');
                    } else {
                      return ListTile(
                        title: Text(
                          'Nome da ONG:',
                          //style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${snapshot.data}'),
                      );
                    }
                  },
                ),
                SizedBox(height: 8.0),

                FutureBuilder<String>(
                  future: _getProductName(widget.alertDetails['idDoacao']),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Erro ao carregar o nome da ONG');
                    } else {
                      return ListTile(
                        title: Text(
                          'Doação:',
                          //style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${snapshot.data}'),
                      );
                    }
                  },
                ),

                //----------------- Data recolhimento --------------------------------//
                if (widget.alertDetails['dataRecolhimento'] is Timestamp)
                  ListTile(
                    title: Text(
                      'Data de Recolhimento: ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    subtitle: Text(
                        '${_formatDateTime(widget.alertDetails['dataRecolhimento'] as Timestamp)}'),
                  ),
                SizedBox(height: 8.0),
                //------------------- Horario de recolhimento ---------------------//
                ListTile(
                  title: Text(
                    'Horário de Recolhimento: ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  subtitle: Text('${(widget.alertDetails['horarioRecolhimento'])}'),
                ),
                SizedBox(height: 8.0),

                //------------------- Descrição ------------------------------------//
                ListTile(
                  title: Text(
                    'Observações: ',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  subtitle: Text('${widget.alertDetails['descricao']}'),
                ),

                 SizedBox(height: 8.0),


//------------------- Status da proposta ---------------------//
            

 ListTile(
  title: Text(
    'Status: ',
    style: TextStyle(fontSize: 16.0),
  ),
  subtitle: widget.alertDetails['status']
      ? widget.alertDetails['aceite']
          ? Text('Proposta aceita')
          : Text('Proposta não aceita')
      : Text('Esperando resposta doador'),
),

SizedBox(height: 60.0),





                // Botões de aceitar e recusar
                if (isAlarmActive)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //botão recusar
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.red.withOpacity(
                                0.7), // Define a cor para o botão "Recusar"
                          ),
                          minimumSize:
                              MaterialStateProperty.all(const Size(200, 50)),
                        ),
                        onPressed: () {
                          recusarRecolhimentoNoFirestore(
                              widget.alertDetails['idDoacao']);
                          Navigator.pop(context);
                        },
                        child: Text('Recusar'),
                      ),

                      //botão aceitar
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          minimumSize:
                              MaterialStateProperty.all(const Size(200, 50)),
                        ),
                        onPressed: () {
                          aceitarRecolhimentoNoFirestore(
                              widget.alertDetails['idDoacao']);
                              Navigator.pop(context);
                        },
                        child: Text('Aceitar'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(Timestamp timestamp) {
    DateTime dateTime =
        timestamp.toDate(); // Convertendo o Timestamp para DateTime
    return DateFormat('dd/MM/yyyy').format(dateTime); // Formatando a data
  }

  String _formatTime(Timestamp timestamp) {
    DateTime dateTime =
        timestamp.toDate(); // Convertendo o Timestamp para DateTime
    return DateFormat.Hm().format(dateTime); // Formatando o horário
  }
}
