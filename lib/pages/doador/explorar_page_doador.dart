import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/ong.dart';
import 'package:doa_conecta_app/pages/doador/notificacao/notificacao_page.dart';
import 'package:doa_conecta_app/pages/doador/perfilOng.dart';
import 'package:flutter/material.dart';

class ExplorarDoadorPage extends StatefulWidget {
  @override
  _ExplorarDoadorPageState createState() => _ExplorarDoadorPageState();
}

class _ExplorarDoadorPageState extends State<ExplorarDoadorPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<ONG> ongs = [];
  List<ONG> ongsFiltradas = [];
  bool isLoading = true; // Adicionando uma variável para controlar o estado de carregamento

  //-------------------- PROCURAR ONGS NO FIREBASE ---------------------------//
  @override
  void initState() {
    super.initState();
    _carregarDadosFirestore();
  }

  Future<void> _carregarDadosFirestore() async {
    try {
      QuerySnapshot ongsSnapshot = await _firestore.collection('ong').get();

      List<ONG> ongsFromFirestore = ongsSnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Convertendo a String para DateTime e fornecendo um valor padrão se a conversão falhar
        DateTime dataCriacao =
            DateTime.tryParse(data['dataCriacao'] ?? '') ?? DateTime.now();

        return ONG(
          nome: data['nome'] ?? '',
          endereco: data['endereco'] ?? '',
          fotoPerfil: data['fotoPerfil'] ?? '',
          cnpj: data['cnpj'] ?? '',
          dataCriacao: dataCriacao,
          numero: data['numero'] ?? '',
          complemento: data['complemtento'] ?? '',
          // Adicione os outros campos da ONG conforme sua estrutura
        );
      }).toList();

      setState(() {
        ongs = ongsFromFirestore;
        ongsFiltradas = List.from(ongs);
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
                  builder: (context) => AlertPage(),
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
                    ongsFiltradas = List.from(ongs);
                  } else {
                    ongsFiltradas = ongs
                        .where((ong) =>
                            ong.nome
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            ong.endereco
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                        .toList();
                  }
                });
              },
              decoration: InputDecoration(
                labelText: "Pesquisar ONGs",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          //-------------------------- LISTA DE ONGS ----------------------------//
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  strokeWidth: 3,)) // Indicador de progresso enquanto carrega
                : ListView.builder(
              itemCount: ongsFiltradas.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(16.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          ongsFiltradas[index].fotoPerfil != null &&
                                  ongsFiltradas[index].fotoPerfil!.isNotEmpty
                              ? NetworkImage(ongsFiltradas[index].fotoPerfil!)
                              : AssetImage('caminho/para/imagem_padrao.png')
                                  as ImageProvider<Object>?,
                    ),
                    title: Text(ongsFiltradas[index].nome),
                    subtitle: Text(ongsFiltradas[index].endereco),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VerPerfilOngPage(),
                        ),
                      );
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
}
