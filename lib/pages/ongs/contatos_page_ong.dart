

/*class ContatoPage extends StatefulWidget {
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
                                    builder: (context) => MensagemOngPage()));
                  
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

*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/doador.dart';
import 'package:doa_conecta_app/doacao.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ContatoPage extends StatefulWidget {
  const ContatoPage({Key? key}) : super(key: key);

  @override
  State<ContatoPage> createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  late String idOng;
  List<Donation> doacoes = []; // Certifique-se de declarar a lista de doações

  @override
  void initState() {
    super.initState();
    obterIdOng();
  }

  Future<void> obterIdOng() async {
    try {
      // Obtém o usuário autenticado atualmente
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Obtém o ID do usuário autenticado
        idOng = user.uid;

        // Atualiza a lista de doações após obter o ID da ONG
        await obterDoacoesDaOng(idOng); // Passando o ID da ONG como argumento
      }
    } catch (e) {
      print('Erro ao obter o ID da ONG: $e');
    }
  }

  Future<void> obterDoacoesDaOng(String idOng) async {
    try {
      QuerySnapshot doacoesSnapshot = await FirebaseFirestore.instance
          .collection('doacao')
          .where('idONG', isEqualTo: idOng)
          .get();

      List<Donation> listaDoacoes = doacoesSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Donation(
          id: doc.id,
          categoria: data['categoria'],
          nomeProduto: data['nomeProduto'],
          descricao: data['descricao'],
          qualidade: data['qualidade'],
          tamanho: data['tamanho'],
          enderecoRetirada: data['enderecoRetirada'],
          fotosURLs: List<String>.from(data['fotosURLs']),
          dataPublicacao: (data['dataPublicacao'] as Timestamp).toDate(),
          status: data['status'],
          idONG: data['idONG'],
          idDoador: data['idDoador'],
        );
      }).toList();

      setState(() {
        doacoes = listaDoacoes;
      });
    } catch (e) {
      print('Erro ao obter as doações da ONG: $e');
    }
  }

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
             ListView.builder(
              itemCount: doacoes.length == 0 ? 1 : doacoes.length,
              itemBuilder: (context, index) {
                if (doacoes.isEmpty) {
                  return Center(
                    child: Container(
                      //width: 50, // Defina a largura desejada
                      height: 50, // Defina a altura desejada
                      child: const Text('Sem doações encontradas.'),
                    )
                  );
                } else {
                  final donation = doacoes[index];
                  return ListTile(
                    title: Text(donation.nomeProduto),
                    subtitle: Text(donation.descricao),
                    onTap: () {
                      // Código para abrir uma tela para enviar mensagens ao doador
                    },
                  );
                }
              },
            ),
            const Center(
              child: Text('Conversas Fechadas'),
            ),
          ],
        ),
      ),
    );
  }
}
