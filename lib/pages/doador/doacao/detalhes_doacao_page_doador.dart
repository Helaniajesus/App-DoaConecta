import 'package:doa_conecta_app/doacao.dart';
import 'package:doa_conecta_app/pages/doador/firebase/doacao_firebase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonationDetails extends StatelessWidget {
  final Donation donation;

  DonationDetails({required this.donation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Detalhes da Doação'),
        centerTitle: true,
        leadingWidth: 100.0,
      ),
      //---------------------------- procurar no firebase nome da ong --------------------------------//
      body: donation.idONG.isNotEmpty
          ? StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('ong')
                  .doc(donation.idONG)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      width: 50, // Defina a largura desejada
                      height: 50, // Defina a altura desejada
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        strokeWidth: 3,
                      ),
                    ),
                  );
                }

                if (donation.idONG.isEmpty ||
                    !snapshot.hasData ||
                    snapshot.data == null) {
                  return buildDonationDetails(context, donation, ongName: '');
                }

                final ongData = snapshot.data;
                final ongName = ongData != null ? ongData['nome'] : '';

                return buildDonationDetails(context, donation,
                    ongName: ongName);
              },
            )
          : buildDonationDetails(context, donation, ongName: ''),
    );
  }

  //----------------------------------- Mostrar informações doacão -------------------------------//
  Widget buildDonationDetails(BuildContext context, Donation donation,
      {required String ongName}) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        ListTile(
          title: Text('Categoria'),
          subtitle: Text(donation.categoria ?? ''),
        ),
        ListTile(
          title: Text('Nome do Produto'),
          subtitle: Text(donation.nomeProduto ?? ''),
        ),
        ListTile(
          title: Text('Descrição'),
          subtitle: Text(donation.descricao ?? ''),
        ),
        ListTile(
          title: Text('Estado de Qualidade'),
          subtitle: Text(donation.qualidade ?? ''),
        ),
        ListTile(
          title: Text('Tamanho'),
          subtitle: Text(donation.tamanho ?? ''),
        ),
        ListTile(
          title: Text('Endereço de Retirada'),
          subtitle: Text(donation.enderecoRetirada ?? ''),
        ),
        ListTile(
          title: Text('Data de Publicação'),
          subtitle: Text(donation.dataPublicacao != null
              ? DateFormat('dd/MM/yyyy').format(donation.dataPublicacao!)
              : ''),
        ),
        ListTile(
          title: Text('Status'),
          subtitle: Text(donation.status != null
              ? (donation.status! ? 'Em aberto' : 'Doação realizada')
              : ''),
        ),
        ListTile(
          title: Text('Destinatário'),
          subtitle: Text(ongName),
        ),
        ListTile(
          title: Text('Fotos'),
          subtitle: donation.fotosURLs != null && donation.fotosURLs.isNotEmpty
              ? SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: donation.fotosURLs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Image.network(
                          donation.fotosURLs[index],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                )
              : Text('Nenhuma foto disponível'),
        ),
        SizedBox(),

        //------------------------ botão de exclusão caso doação estiver em aberto -------------------------//
        donation.status == true // Verificando se a doação está aberta
            ? ElevatedButton(
                onPressed: () async {
                  await apagarDoacaoNoFirebase(donation.id);
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors
                      .green), // Cor alterada para vermelho para melhor identificação
                  minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                ),
                child: Text('Apagar Doação'),
              )
            : SizedBox(), // Se a doação não estiver aberta, não exibe o botão
      ],
    );
  }
}
