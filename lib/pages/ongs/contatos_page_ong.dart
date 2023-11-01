
import 'package:doa_conecta_app/pages/ongs/mensagem_page.dart';
import 'package:flutter/material.dart';

class ContatoPage extends StatefulWidget {
  const ContatoPage({Key? key}) : super(key: key);

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 100.0,
          title: const TabBar(
            tabs: [
              Tab(text: 'Conversas Abertas'),
              Tab(text: 'Conversas Fechadas'),
            ],
             indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            // Conteúdo da aba de Conversas Abertas
            ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(contact.avatar),
                  ),
                  title: Text(contact.name),
                  subtitle: Text(contact.status),
                  onTap: () {
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MensagemOngPage()));
                  
                  },
                );
              },
            ),
            // Conteúdo da aba de Conversas Fechadas
            const Center(
              child: Text('Conversas Fechadas'),
            ),
          ],
        ),
      ),
    );
  }
}

class Contact {
  final String name;
  final String status;
  final String avatar;

  Contact({
    required this.name,
    required this.status,
    required this.avatar,
  });
}

final List<Contact> contacts = [
  Contact(
    name: 'João',
    status: 'Disponível',
    avatar: 'assets/avatar1.jpg',
  ),
  Contact(
    name: 'Maria',
    status: 'Ocupada',
    avatar: 'assets/avatar2.jpg',
  ),
  Contact(
    name: 'Pedro',
    status: 'No trabalho',
    avatar: 'assets/avatar3.jpg',
  ),
];
