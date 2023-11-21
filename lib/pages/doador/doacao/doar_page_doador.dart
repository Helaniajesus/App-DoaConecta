import 'package:doa_conecta_app/pages/doador/doacao/detalhes_doacao_page_doador.dart';
import 'package:doa_conecta_app/pages/doador/doacao/quero_doar_page.dart';
import 'package:doa_conecta_app/doacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoarDoadorPage extends StatefulWidget {
  const DoarDoadorPage({Key? key}) : super(key: key);

  @override
  State<DoarDoadorPage> createState() => _DoarDoadorPageState();
}

class _DoarDoadorPageState extends State<DoarDoadorPage> {

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
                    child: const Text('Doações Abertas'),
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
                    child: const Text('Doações Fechadas'),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('doacao').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                }
                final data = snapshot.data;
                if (data == null || data.docs.isEmpty) {
                  return Text('Sem doações encontradas.');
                }
                List<DocumentSnapshot> donationsToShow = [];
                if (showOpenDonations) {
                  donationsToShow = data.docs.where((doc) => doc['status'] == true).toList();
                } else {
                  donationsToShow = data.docs.where((doc) => doc['status'] == false).toList();
                }
                if (donationsToShow.isEmpty) {
                  return Text(showOpenDonations ? 'Sem doações abertas.' : 'Sem doações fechadas.');
                }
                return ListView.builder(
                  itemCount: donationsToShow.length,
                  itemBuilder: (context, index) {
                    final donationData = donationsToShow[index].data() as Map<String, dynamic>;
                    final timestamp = donationData['dataPublicacao'] as Timestamp?;
                    final formattedDate = timestamp != null ? DateFormat('dd/MM/yyyy').format(timestamp.toDate()) : '';


                    return InkWell(
                      onTap: () {
                        // Aqui você pode criar um objeto Donation com base nos dados da doação selecionada
                        Donation donation = Donation(
                          categoria: donationData['categoria'] ?? '',
                          nomeProduto: donationData['nomeProduto'] ?? '',
                          descricao: donationData['descricao'] ?? '',
                          qualidade: donationData['qualidade'] ?? '',
                          tamanho: donationData['tamanho'] ?? '',
                          enderecoRetirada: donationData['enderecoRetirada'] ?? '',
                          fotosURLs: donationData['fotos'] ?? [], // Aqui, supondo que as fotos sejam uma lista de File
                          dataPublicacao: (donationData['dataPublicacao'] as Timestamp).toDate(),
                          status: donationData['status'] ?? false,
                          idONG: donationData['idONG'] ?? '',
                          idDoador: donationData['idDoador'] ?? '',
                        );
                         print('Doação: $donation');
                         
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DonationDetails(donation: donation),
    ),
  );
                       
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Card(
                          color: const Color.fromARGB(223, 255, 255, 255),
                          margin: const EdgeInsets.all(8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: donationData.containsKey('image') && donationData['image'] != null
                                  ? NetworkImage(donationData['image'] as String)
                                  : AssetImage('caminho_para_imagem_padrao') as ImageProvider<Object>?,
                            ),
                            title: Text(donationData['nomeProduto'] ?? ''),
                            subtitle: Text('Data: $formattedDate'),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
              backgroundColor: MaterialStateProperty.all(Colors.green),
              minimumSize: MaterialStateProperty.all(const Size(200, 50)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QueroDoarPage(),
                ),
              );
            },
            child: const Text('Quero doar'),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}