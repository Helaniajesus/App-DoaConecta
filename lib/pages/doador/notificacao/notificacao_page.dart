/*import 'package:doa_conecta_app/pages/doador/notificacao/detalhes_notificacao_page.dart';
import 'package:doa_conecta_app/pages/doador/notificacao/notificacao.dart';
import 'package:flutter/material.dart';



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
}*/

import 'package:doa_conecta_app/pages/doador/notificacao/detalhes_notificacao_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AlertPage extends StatefulWidget {
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User _currentUser;

  bool _isLoading = true; // Adicionando uma variável de carregamento

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    _currentUser = await _auth.currentUser!;
    setState(() {
      _isLoading =
          false; // Quando o usuário é carregado, definimos o isLoading como false
    });
  }

  Future<List<Map<String, dynamic>>> _getAlertsForDonor() async {
    List<Map<String, dynamic>> alerts = [];

    try {
      QuerySnapshot<Map<String, dynamic>> donationQuery = await _firestore
          .collection('doacao')
          .where('doador', isEqualTo: _currentUser.uid)
          .get();

      List<String> donationIds =
          donationQuery.docs.map((doc) => doc.id).toList();

      for (String donationId in donationIds) {
        QuerySnapshot<Map<String, dynamic>> alertQuery = await _firestore
            .collection('alertas')
            .where('idDoacao', isEqualTo: donationId)
            .get();

        alerts.addAll(
            alertQuery.docs.map((alertDoc) => alertDoc.data()).toList());
      }
    } catch (e) {
      print('Erro ao buscar alertas: $e');
    }

    return alerts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Notificações'),
      ),
      body: _isLoading
  ? const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        strokeWidth: 3,
      ),
    )
  : FutureBuilder(
      // Restante do código

              future: _getAlertsForDonor(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        strokeWidth: 3,));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text(''));
                } else {
                  // ... Código anterior

                 return ListView.builder(
                   padding: EdgeInsets.all(16.0),
  itemCount: snapshot.data!.length,
  itemBuilder: (BuildContext context, int index) {
    Map<String, dynamic> alertData = snapshot.data![index];

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('doacao')
          .doc(alertData['idDoacao'])
          .get(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot> doacaoSnapshot) {
         if (doacaoSnapshot.hasError) {
          return Text('Erro: ${doacaoSnapshot.error}');
        } else if (!doacaoSnapshot.hasData ||
            !doacaoSnapshot.data!.exists) {
          return Text('');
        } else {
          Map<String, dynamic> doacaoData =
              doacaoSnapshot.data!.data() as Map<String,
                  dynamic>;

          
            String produto = doacaoData['nomeProduto']; // Nome da ONG

          String idOng = doacaoData['ong'];

          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('ong')
                .doc(idOng)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> ongSnapshot) {
              if (ongSnapshot.hasError) {
                return Text('Erro: ${ongSnapshot.error}');
              } else if (!ongSnapshot.hasData ||
                  !ongSnapshot.data!.exists) {
                return Text('');
              } else {
                Map<String, dynamic> ongData =
                    ongSnapshot.data!.data() as Map<String,
                        dynamic>;

                String nomeOng = ongData['nome']; // Nome da ONG

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AlertDetailsPage(alertDetails: alertData),
                      ),
                    ).then((_) {
                      
                     setState(() {
         _AlertPageState();});
      });
                  },
                  child: Card(
                    margin: EdgeInsets.all(10.0),
                    child: 
                    Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0), // Margem vertical para este elemento
          child: ListTile(
                      title: Text(
                        '$nomeOng enviou uma proposta de recolhimento para a doação: $produto',
                        // Aqui você exibirá o nome da ONG correspondente ao alerta
                      ),
                    ),
                  ),
                  ), 
                    
                );
              }
            },
          );
        }
      },
    );
  },
);
                }
                  },
  ),
    );
  }
}
 

