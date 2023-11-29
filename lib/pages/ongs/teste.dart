
/*import 'package:doa_conecta_app/doacao.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoacaoOngPage extends StatefulWidget {
  const DoacaoOngPage({Key? key}) : super(key: key);

  @override
  State<DoacaoOngPage> createState() => _DoacaoONGPageState();
}

class _DoacaoONGPageState extends State<DoacaoOngPage> {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

   // Listas para armazenar as doações
      List<Donation> openDonations = [];
      List<Donation> closedDonations = [];


  late User? _user; // Usuário logado


  }

  bool showOpenDonations = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: 100.0,
        title: const Text('Histórico de Doações'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              //------------- BOTAO DOAÇOES ABERTAS----------------//
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    
                  },
                  child: Container(
                    color: showOpenDonations
                        ? const Color.fromARGB(255, 51, 128, 53)
                        : Colors.grey,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: const Text('Doações a Recolher'),
                  ),
                ),
              ),
              //---------------- BOTAO DOACOES FECHADAS -------------------//
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showOpenDonations = false;
                    });
                  },
                  child: Container(
                    color: !showOpenDonations
                        ? const Color.fromARGB(255, 51, 128, 53)
                        : Colors.grey,
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: const Text('Doações Recolhidas'),
                  ),
                ),
              ),
            ],
          ),
          //------------- LISTA DE DOACOES --------------------------//
             Expanded(
            child: openDonations.isEmpty && closedDonations.isEmpty
                ? Center(
                    child: Text('Sem doações encontradas'),
                  )
                : ListView.builder(
                    itemCount: showOpenDonations
                        ? openDonations.length
                        : closedDonations.length,
                    itemBuilder: (context, index) {
                      final donation = showOpenDonations
                          ? openDonations[index]
                          : closedDonations[index];
                      return InkWell(
                        onTap: () {
                          // Ação a ser executada quando o card for pressionado
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Card(
                            // ... (restante do código)
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}*/