/*import 'package:flutter/material.dart';

class ExplorarDoadorPage extends StatefulWidget {
  const ExplorarDoadorPage({Key? key}) : super(key: key);

  @override
  State<ExplorarDoadorPage> createState() => _ExplorarDoadorPageState();
}

class _ExplorarDoadorPageState extends State<ExplorarDoadorPage> {
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



import 'package:doa_conecta_app/pages/doador/notificacao/notificacao_page.dart';
import 'package:doa_conecta_app/pages/doador/perfilOng.dart';
import 'package:flutter/material.dart';

class Ong {
  final String nome;
  final String endereco;
  final String imagem;

  Ong({required this.nome, required this.endereco, required this.imagem});
}

class ExplorarDoadorPage extends StatefulWidget {
  @override
  _ExplorarDoadorPageState createState() => _ExplorarDoadorPageState();
}

class _ExplorarDoadorPageState extends State<ExplorarDoadorPage> {
  final List<Ong> ongs = [
    Ong(
      nome: 'ONG A',
      endereco: 'Rua A, 123 - Pirituba',
      imagem: 'https://via.placeholder.com/150',
    ),
    Ong(
      nome: 'ONG B',
      endereco: 'Avenida B, 456 - Pirituba',
      imagem: 'https://via.placeholder.com/150',
    ),
    Ong(
      nome: 'ONG C',
      endereco: 'Travessa C, 789 - Pirituba',
      imagem: 'https://via.placeholder.com/150',
    ),
    Ong(
      nome: 'ONG D',
      endereco: 'Av Mutinga C, 789 - Guarulhos',
      imagem: 'https://via.placeholder.com/150',
    ),
    Ong(
      nome: 'ONG E',
      endereco: 'Av Prof Costa, 789 - Carapicuiba',
      imagem: 'https://via.placeholder.com/150',
    ),
    // Adicione mais ONGs conforme necessário
  ];

  List<Ong> ongsFiltradas = [];

  @override
  void initState() {
    super.initState();
    // Inicialmente, exibe todas as ONGs
    ongsFiltradas = List.from(ongs);
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
          actions: [
          IconButton(
            icon: Icon(Icons.notifications), // Ícone de notificação
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (query) {
                setState(() {
                  if (query.isEmpty) {
                    // Se a consulta estiver vazia, exiba todas as ONGs
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
          Expanded(
            child: ListView.builder(
              itemCount: ongsFiltradas.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(16.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(ongsFiltradas[index].imagem),
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
