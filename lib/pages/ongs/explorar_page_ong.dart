/*import 'package:flutter/material.dart';

class ExplorarOngPage extends StatefulWidget {
  const ExplorarOngPage({Key? key}) : super(key: key);

  @override
  State<ExplorarOngPage> createState() => _ExplorarOngPageState();
}

class _ExplorarOngPageState extends State<ExplorarOngPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 100.0,
          title: Text("DoaConecta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),

        //-------------------- BARRA DE PESQUISA -----------------------------------//
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          },
        ),
      ),
    ); 
  }
}*/

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/doacao.dart';
import 'package:flutter/material.dart';


class ExplorarOngPage extends StatefulWidget {
  @override
  _ExplorarOngPageState createState() => _ExplorarOngPageState();
}

class _ExplorarOngPageState extends State<ExplorarOngPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Donation> doacoes = [];
  List<Donation> doacoesFiltradas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDadosFirestore();
  }

  Future<void> _carregarDadosFirestore() async {
    try {
      QuerySnapshot doacoesSnapshot = await _firestore.collection('doacoes').get();

      List<Donation> doacoesFromFirestore = doacoesSnapshot.docs.map((doc) {
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
          idONG: data['idONG'] ?? '',
          idDoador: data['idDoador'] ?? '',
        );
      }).toList();

      setState(() {
        doacoes = doacoesFromFirestore;
        doacoesFiltradas = List.from(doacoes);
        isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar dados do Firestore: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("DoaConecta"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: 100.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  if (query.isEmpty) {
                    doacoesFiltradas = List.from(doacoes);
                  } else {
                    doacoesFiltradas = doacoes
                        .where((doacao) =>
                            doacao.nomeProduto
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            doacao.enderecoRetirada
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                        .toList();
                  }
                });
              },
              decoration: InputDecoration(
                labelText: "Pesquisar Doações",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: doacoesFiltradas.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(16.0),
                        child: ListTile(
                          title: Text(doacoesFiltradas[index].nomeProduto),
                          subtitle:
                              Text(doacoesFiltradas[index].enderecoRetirada),
                          onTap: () {
                            // Implemente a ação ao clicar na doação
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/doacao.dart';
import 'package:doa_conecta_app/ong.dart';
import 'package:doa_conecta_app/pages/doador/notificacao/notificacao_page.dart';
import 'package:doa_conecta_app/pages/doador/perfilOng.dart';
import 'package:doa_conecta_app/pages/ongs/doacao/detalhes_doacao_explorar_ong.dart';
import 'package:doa_conecta_app/pages/ongs/doacao/detalhes_doacao_ong.dart';
import 'package:flutter/material.dart';

class ExplorarOngPage extends StatefulWidget {
  @override
  _ExplorarOngPageState createState() => _ExplorarOngPageState();
}

class _ExplorarOngPageState extends State<ExplorarOngPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Donation> doacoes = [];
  List<Donation> doacoesFiltradas = [];
  bool isLoading = true; // Adicionando uma variável para controlar o estado de carregamento

  //-------------------- PROCURAR ONGS NO FIREBASE ---------------------------//
  @override
  void initState() {
    super.initState();
    _carregarDadosFirestore();
  }

  Future<void> _carregarDadosFirestore() async {
    try {
      QuerySnapshot doacoesSnapshot = await _firestore.collection('doacao').get();

      List<Donation> doacoesFromFirestore = doacoesSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Convertendo a String para DateTime e fornecendo um valor padrão se a conversão falhar
        DateTime dataCriacao =
            DateTime.tryParse(data['dataCriacao'] ?? '') ?? DateTime.now();

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
      }).toList();

      setState(() {
        doacoes = doacoesFromFirestore;
        doacoesFiltradas = List.from(doacoes);
        isLoading = false; // Marcando como concluído o carregamento
      });
    } catch (e) {
      print('Erro ao carregar dados do Firestore: $e');
       setState(() {
        isLoading = false; // Em caso de erro, marca como concluído também
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("DoaConecta"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: 100.0,
        //------------------- Botão de notificação -----------------------//
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificacoesPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          //------------------ Barra de Pesquisa -------------------------------//
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  if (query.isEmpty) {
                    doacoesFiltradas = List.from(doacoes);
                  } else {
                    doacoesFiltradas = doacoes
                        .where((doacao) =>
                          doacao.nomeProduto.toLowerCase().contains(query.toLowerCase()) ||
                          doacao.enderecoRetirada.toLowerCase().contains(query.toLowerCase()) ||
                          doacao.categoria.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                  }
                });
              },
              decoration: InputDecoration(
                labelText: "Pesquisar doações",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          //-------------------------- LISTA DE DOAÇOES ----------------------------//
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  strokeWidth: 3,)) // Indicador de progresso enquanto carrega
                : ListView.builder(
              itemCount: doacoesFiltradas.length,
              itemBuilder: (context, index) {
                if (doacoesFiltradas[index].idONG.isEmpty) {
                return Card(
                  margin: EdgeInsets.all(16.0),
                  child: ListTile(
                    leading: CircleAvatar(
  backgroundImage: doacoesFiltradas[index].fotosURLs != null &&
          doacoesFiltradas[index].fotosURLs.isNotEmpty
      ? NetworkImage(doacoesFiltradas[index].fotosURLs[0]) // Usando a primeira URL da lista
      : AssetImage('caminho/para/imagem_padrao.png') as ImageProvider<Object>?,
),

                    title: Text(doacoesFiltradas[index].nomeProduto),
                    subtitle: Text(doacoesFiltradas[index].enderecoRetirada),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DonationDetailsExplorarOng(donation: doacoesFiltradas[index]),
                        ),
                      );
                    },
                  ),
                );
              } else {
                  return SizedBox(); // Retorna um widget vazio para as doações com ID de ONG preenchido
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
