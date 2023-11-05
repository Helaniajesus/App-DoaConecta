import 'package:doa_conecta_app/doacao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Categoria'),
            subtitle: Text(donation.categoria),
          ),
          ListTile(
            title: Text('Nome do Produto'),
            subtitle: Text(donation.nomeProduto),
          ),
          ListTile(
            title: Text('Descrição'),
            subtitle: Text(donation.descricao),
          ),
          ListTile(
            title: Text('Estado de Qualidade'),
            subtitle: Text(donation.qualidade),
          ),
          ListTile(
            title: Text('Tamanho'),
            subtitle: Text(donation.tamanho),
          ),
          ListTile(
            title: Text('Endereço de Retirada'),
            subtitle: Text(donation.enderecoRetirada),
          ),
          ListTile(
            title: Text('Data de Publicação'),
            subtitle:
                Text(DateFormat('dd/MM/yyyy').format(donation.dataPublicacao)),
          ),
          ListTile(
            title: Text('Data de Retirada'),
            subtitle:
                Text(DateFormat('dd/MM/yyyy').format(donation.dataRetirada)),
          ),
          ListTile(
            title: Text('Status'),
            subtitle: Text(donation.status ? 'Aberta' : 'Fechada'),
          ),
          ListTile(
            title: Text('Destinatário'),
            subtitle: Text(donation.destinatario),
          ),
          ListTile(
            title: Text('Fotos'),
            subtitle: Column(
              children: donation.fotos.split(',').map((imageUrl) {
                return Image.network(
                  imageUrl.trim(), // Para remover espaços em branco em URLs
                  width:
                      100, // Defina o tamanho da imagem conforme sua preferência
                  height: 100,
                  fit: BoxFit
                      .cover, // Pode ajustar isso para o comportamento de exibição desejado
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
