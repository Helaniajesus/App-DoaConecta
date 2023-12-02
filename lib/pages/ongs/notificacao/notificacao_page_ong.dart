
import 'package:doa_conecta_app/pages/doador/notificacao/detalhes_notificacao_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AlertPageONG extends StatefulWidget {
  @override
  _AlertPageONG createState() => _AlertPageONG();
}

class _AlertPageONG extends State<AlertPageONG> {
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
Future<List<Map<String, dynamic>>> _getAlertsForOng() async {
  List<Map<String, dynamic>> alerts = [];

  try {
    QuerySnapshot<Map<String, dynamic>> donationQuery = await _firestore
        .collection('doacao')
        .where('ong', isEqualTo: _currentUser.uid)
        .get();

    List<String> donationIds =
        donationQuery.docs.map((doc) => doc.id).toList();

    for (String donationId in donationIds) {
  QuerySnapshot<Map<String, dynamic>> alertQuery = await _firestore
    .collection('alertas')
    .where('idDoacao', isEqualTo: donationId)
    .get();

  List<Map<String, dynamic>> filteredAlerts = alertQuery.docs
    .map((alertDoc) => alertDoc.data())
    .where((alertData) => alertData['status'] == true)
    .toList();

  alerts.addAll(filteredAlerts);
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

              future: _getAlertsForOng(),
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

          String idDoador = doacaoData['doador'];

          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('doador')
                .doc(idDoador)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> ongSnapshot) {
              if (ongSnapshot.hasError) {
                return Text('Erro: ${ongSnapshot.error}');
              } else if (!ongSnapshot.hasData ||
                  !ongSnapshot.data!.exists) {
                return Text('');
              } else {
                Map<String, dynamic> doadorData =
                    ongSnapshot.data!.data() as Map<String,
                        dynamic>;

                String nomeDoador = doadorData['nome']; // Nome da ONG

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
         _AlertPageONG();});
      });
                  },
                  child: Card(
                    margin: EdgeInsets.all(10.0),
                    child: 
                    Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0), // Margem vertical para este elemento
          child: ListTile(
                      title: Text(
                        'Doador: $nomeDoador respondeu sua proposta de recolhimento para a doação: $produto',
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
 

