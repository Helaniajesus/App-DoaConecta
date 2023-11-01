import 'package:flutter/material.dart';

class DoacaoOngPage extends StatefulWidget {
  const DoacaoOngPage({Key? key}) : super(key: key);

  @override
  State<DoacaoOngPage> createState() => _DoacaoONGPageState();
}
//-------------CLASSE DOACAO-----------------------//
class Donation {
  final String title;
  final String status;
  final String date;
  final String imageUrl;

  Donation(this.title, this.status, this.date, this.imageUrl);
}

class _DoacaoONGPageState extends State<DoacaoOngPage> {

  //----------- CRIAR DOACOES ----------------------//
  final List<Donation> openDonations = [
    Donation('Doação Aberta 1', 'Aberta', '01/03/2023', 'url_da_imagem_1'),
    Donation('Doação Aberta 2', 'Aberta', '31/05/2023', 'url_da_imagem_2'),
  ];

  final List<Donation> closedDonations = [
    Donation('Doação Fechada 1', 'Fechada', '10/09/2023', 'url_da_imagem_3'),
    Donation('Doação Fechada 2', 'Fechada', '1/02/2023', 'url_da_imagem_4'),
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
              //------------- BOTAO DOAÇOES ABERTAS----------------//
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
            child: ListView.builder(
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
                      color: const Color.fromARGB(223, 255, 255, 255),
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(10), // Espaçamento interno dentro do card
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(donation.imageUrl),
                          ),
                          title: Text(donation.title),
                          subtitle: Text('Data: ${donation.date}'),
                        ),
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
