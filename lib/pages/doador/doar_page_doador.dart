import 'package:doa_conecta_app/pages/doador/doacao_page_doador.dart';
import 'package:doa_conecta_app/pages/doador/quero_doar_page.dart';
import 'package:doa_conecta_app/doacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoarDoadorPage extends StatefulWidget {
  const DoarDoadorPage({Key? key}) : super(key: key);

  @override
  State<DoarDoadorPage> createState() => _DoarDoadorPageState();
}

class _DoarDoadorPageState extends State<DoarDoadorPage> {

  //----------- CRIAR DOACOES ----------------------//
  final List<Donation> openDonations = [
    Donation(
      'A123',
      'Móveis',
      'Sofá',
      'Um sofá em ótimas condições',
      'Boa',
      '1.5m x 3.2m',
      '123 Main St',
      'url_da_imagem_1',
      DateTime(2023, 3, 01),
      DateTime(2023, 3, 10),
      false,
     '' 
    ),
  ];

  final List<Donation> closedDonations = [
    Donation(
      'A123',
      'Móveis',
      'Sofá',
      'Um sofá em ótimas condições',
      'Boa',
      '1.5m x 3.2m',
      '123 Main St',
      'url_da_imagem_1',
      DateTime(2023, 3, 01),
      DateTime(2023, 3, 10),
      false,
      'ONG Sonhar'
    ),
  ];

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
            child: ListView.builder(
              itemCount: showOpenDonations
                  ? openDonations.length
                  : closedDonations.length,
              itemBuilder: (context, index) {
                final donation = showOpenDonations
                    ? openDonations[index]
                    : closedDonations[index];
                final formattedDate = DateFormat('dd/MM/yyyy').format(donation.dataPublicacao); // Formatar a data
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonationDetails(donation: donation),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Card(
                      color: const Color.fromARGB(223, 255, 255, 255),
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(donation.fotos),
                          ),
                          title: Text(donation.nomeProduto),
                          subtitle: Text('Data: $formattedDate'),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          //------------------------BOTÃO QUERO DOAR ---------------------------//
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