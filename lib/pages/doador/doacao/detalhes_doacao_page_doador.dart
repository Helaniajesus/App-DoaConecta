import 'package:doa_conecta_app/doacao.dart';
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
      body: donation.idONG.isNotEmpty ? StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('ongs').doc(donation.idONG).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (donation.idONG.isEmpty || !snapshot.hasData || snapshot.data == null) {
            return buildDonationDetails(donation, ongName: '');
          }

          final ongData = snapshot.data;
          final ongName = ongData != null ? ongData['nome'] : '';

          return buildDonationDetails(donation, ongName: ongName);
        },
      ) : buildDonationDetails(donation, ongName: ''),
    );
  }

  Widget buildDonationDetails(Donation donation, {required String ongName}) {
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
          subtitle: Text(donation.status != null ? (donation.status! ? 'Em aberto' : 'Doação realizada') : ''),
        ),
        ListTile(
          title: Text('Destinatário'),
          subtitle: Text(ongName),
        ),
      ],
    );
  }
}
