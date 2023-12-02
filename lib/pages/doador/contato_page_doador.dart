import 'package:doa_conecta_app/ong.dart';
import 'package:doa_conecta_app/pages/doador/chat_doador.dart';
import 'package:doa_conecta_app/pages/doador/firebase/doador_firebase.dart';
import 'package:doa_conecta_app/pages/ongs/chat_ong.dart';
import 'package:doa_conecta_app/pages/ongs/firebase_ong/ong_firebase.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/doador.dart';
import 'package:doa_conecta_app/doacao.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContatoPageDoador extends StatefulWidget {
  const ContatoPageDoador({Key? key}) : super(key: key);

  @override
  State<ContatoPageDoador> createState() => _ContatoPageDoadorState();
}

Future<List<Donation>> obterDoacoesDoDoador(String idDoador) async {
  try {
    QuerySnapshot doacoesSnapshot = await FirebaseFirestore.instance
        .collection('doacao')
        .where('doador', isEqualTo: idDoador)
        .get();

    List<Donation> listaDoacoes = doacoesSnapshot.docs
        .map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Donation(
            id: doc.id,
            categoria: data['categoria'] ?? '',
            nomeProduto: data['nomeProduto'] ?? '',
            descricao: data['descricao'] ?? '',
            qualidade: data['qualidade'] ?? '',
            tamanho: data['tamanho'] ?? '',
            enderecoRetirada: data['enderecoRetirada'] ?? '',
            fotosURLs: List<String>.from(data['fotosURLs'] ?? []),
            dataPublicacao: data['dataPublicacao'].toDate(),
            status: data['status'] ?? false,
            idONG: data['ong'] ?? '',
            idDoador: data['doador'] ?? '',
          );
        })
        .where((donation) =>
            donation.idONG.isNotEmpty) // Filtra documentos com 'ong' não vazio
        .toList();

    return listaDoacoes;
  } catch (e) {
    print('Erro ao obter as doações do doador: $e');
    return []; // Retorna uma lista vazia em caso de erro
  }
}

Future<List<Donation>> obterDoacoesAbertasDaDoador(String idDoador) async {
  List<Donation> doacoes = await obterDoacoesDoDoador(idDoador);
  return doacoes.where((doacao) => doacao.status).toList();
}

Future<List<Donation>> obterDoacoesFechadasDaDoador(String idDoador) async {
  List<Donation> doacoes = await obterDoacoesDoDoador(idDoador);
  return doacoes.where((doacao) => !doacao.status).toList();
}

class _ContatoPageDoadorState extends State<ContatoPageDoador> {
  late String idDoador;
  List<Donation> doacoesAbertas = [];
  List<Donation> doacoesFechadas = [];

  @override
  void initState() {
    super.initState();
    obterIdOng();
  }

  Future<void> obterIdOng() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        idDoador = user.uid;
        await carregarDoacoes();
      }
    } catch (e) {
      print('Erro ao obter o ID da ONG: $e');
    }
  }

  Future<void> carregarDoacoes() async {
    try {
      doacoesAbertas = await obterDoacoesAbertasDaDoador(idDoador);
      doacoesFechadas = await obterDoacoesFechadasDaDoador(idDoador);
      print('Doacoes Abertas: $doacoesAbertas');
      setState(() {}); // Atualiza o estado para refletir as alterações
    } catch (e) {
      print('Erro ao carregar as doações: $e');
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
            // Conteúdo da aba "Conversas Abertas"
            FutureBuilder<List<Donation>>(
              future: obterDoacoesAbertasDaDoador(idDoador),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    strokeWidth: 3,
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Sem doações abertas.'));
                } else {
                  List<Donation> doacoesAbertas = snapshot.data!;
                  return ListView.builder(
                    itemCount: doacoesAbertas.length,
                    itemBuilder: (context, index) {
                      final donation = doacoesAbertas[index];
                      return FutureBuilder(
                        future: obterOngPorId(donation.idONG),
                        builder: (BuildContext context,
                            AsyncSnapshot<ONG?> snapshot) {
                          ONG? ong = snapshot.data;
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: donation.fotosURLs.isNotEmpty
                                  ? NetworkImage(donation.fotosURLs[0])
                                  : AssetImage('caminho_para_imagem_padrao')
                                      as ImageProvider<Object>?,
                            ),
                            title: Text(ong?.nome ?? 'Nome não encontrado'),
                            subtitle: Text(donation.nomeProduto),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DoadorChatPage(ong: ong),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
            FutureBuilder<List<Donation>>(
              future: obterDoacoesFechadasDaDoador(idDoador),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    strokeWidth: 3,
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Sem doações fechadas.'));
                } else {
                  List<Donation> doacoesFechadas = snapshot.data!;
                  return ListView.builder(
                    itemCount: doacoesFechadas.length,
                    itemBuilder: (context, index) {
                      final donationfechada = doacoesFechadas[index];
                      return FutureBuilder(
                        future: obterOngPorId(donationfechada.idONG),
                        builder: (BuildContext context,
                            AsyncSnapshot<ONG?> snapshot) {
                          ONG? ong = snapshot.data;
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: donationfechada
                                      .fotosURLs.isNotEmpty
                                  ? NetworkImage(donationfechada.fotosURLs[0])
                                  : AssetImage('caminho_para_imagem_padrao')
                                      as ImageProvider<Object>?,
                            ),
                            title: Text(ong?.nome ?? 'Nome não encontrado'),
                            subtitle: Text(donationfechada.nomeProduto),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DoadorChatPage(ong: ong),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
