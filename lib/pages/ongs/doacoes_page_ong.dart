import 'package:doa_conecta_app/doacao.dart';
import 'package:doa_conecta_app/pages/ongs/doacao/detalhes_doacao_ong.dart';
import 'package:doa_conecta_app/pages/ongs/doacao/detalhes_doacao_recolhida.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoacaoOngPage extends StatefulWidget {
  const DoacaoOngPage({Key? key}) : super(key: key);

  @override
  State<DoacaoOngPage> createState() => _DoacaoONGPageState();
}

class _DoacaoONGPageState extends State<DoacaoOngPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User? _user; // Usuário logado

  // Listas para armazenar as doações
  List<Donation> openDonations = [];
  List<Donation> closedDonations = [];

  bool isLoading = true;
  bool showOpenDonations = true; // Adicionando a variável showOpenDonations

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser; // Obter usuário logado ao inicializar a página
    if (_user != null) {
      _carregarDoacoesDaOng(_user!.uid); // Carregar doações da ONG
    }
  }

  Future<void> _carregarDoacoesDaOng(String ongId) async {
    try {
      QuerySnapshot doacoesSnapshot = await _firestore
          .collection('doacao')
          .where('ong', isEqualTo: ongId) // Filtrar pelo ID da ONG
          .get();

      setState(() {
        openDonations.clear();
        closedDonations.clear();
      });

      doacoesSnapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;

        Donation donation = Donation(
          id: doc.id,
          categoria: data['categoria'],
          nomeProduto: data['nomeProduto'],
          descricao: data['descricao'],
          qualidade: data['qualidade'],
          tamanho: data['tamanho'],
          enderecoRetirada: data['enderecoRetirada'],
          fotosURLs: List<String>.from(data['fotosURLs'] ?? []),
          dataPublicacao: data['dataPublicacao'] != null &&
                  data['dataPublicacao'] is Timestamp
              ? (data['dataPublicacao'] as Timestamp).toDate()
              : DateTime.now(),
          status: data['status'],
          idONG: data['ong'],
          idDoador: data['doador'],
        );

        if (data['status']) {
          setState(() {
            openDonations.add(donation); // Adiciona à lista de doações abertas
          });
        } else {
          setState(() {
            closedDonations.add(donation); // Adiciona à lista de doações fechadas
          });
        }
      });

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar doações da ONG: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> atualizarDoacoes() async {
    setState(() {
      isLoading = true;
    });
    await _carregarDoacoesDaOng(_user!.uid);
  }

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
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showOpenDonations = true;
                    });
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
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      strokeWidth: 3,
                    ),
                  )
                : (showOpenDonations
                        ? openDonations.isEmpty
                        : closedDonations.isEmpty)
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
                          return GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => showOpenDonations
                                      ? DonationDetailsOng(donation: donation)
                                      : RecolhidaDonationDetailsOng(
                                          donation: donation),
                                ),
                              );

                              if (result != null) {
                                await atualizarDoacoes();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Card(
                                color:
                                    const Color.fromARGB(223, 255, 255, 255),
                                margin: const EdgeInsets.all(8),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        donation.fotosURLs.isNotEmpty
                                            ? NetworkImage(donation.fotosURLs[0])
                                            : AssetImage(
                                                    'caminho_para_imagem_padrao')
                                                as ImageProvider<Object>?,
                                  ),
                                  title: Text(donation.nomeProduto),
                                  subtitle: Text(
                                      'Data: ${DateFormat('dd/MM/yyyy').format(donation.dataPublicacao)}'),
                                ),
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
}
