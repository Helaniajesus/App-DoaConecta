
import 'package:doa_conecta_app/pages/ongs/opcoes_configuracoes_page_ong.dart';
import 'package:doa_conecta_app/pages/ongs/editar_perfil_ong.dart';
import 'package:doa_conecta_app/pages/ongs/perfil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


/*class PerfilOngPage extends StatefulWidget {
  const PerfilOngPage({Key? key}) : super(key: key);

  @override
  State<PerfilOngPage> createState() => _PerfilOngPageState();
}

class _PerfilOngPageState extends State<PerfilOngPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: 100.0,
        title: Text("Perfil"),
        //---------------------- BOTAO EDITAR PERFIL ----------------------------//
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                context: context,
                builder: (context) {
                  return EditarPerfilOng();
                },
              );
            },
            icon: Icon(Icons.add),
          ),
          //-------------------- BOTAO CONFIGURACOES -----------------------------//
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                context: context,
                builder: (context) {
                  return ConfiguracoesOng();
                },
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      //------------------------ CORPO DA PAGINA -----------------------------//
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    //------------------ FOTO PERFIL ----------------------------------//
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/profile_image.jpg'),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nome ONG',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //---------------------- DESCRIÇÃO -------------------------------//
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          'Descrição: Atuamos há mais de 10 anos pela defesa dos animais na cidade de São Paulo.\nEndereço: Av. Oeste, 321, São Paulo - SP \nSite: www.ongamigosanimais.org.br',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  //--------------- DIVISÃO FOTOS -----------------//
                  Container(
                    height: 2, // Ajuste a altura desejada
                    child: const Divider(
                      color: Colors.grey, // Cor da linha
                    ),
                  ),
                  //-------------------- FOTOS ---------------------//
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 9, // Número de fotos
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing:
                            16.0, // Espaço vertical entre as imagens
                        crossAxisSpacing:
                            16.0, // Espaço horizontal entre as imagens
                      ),
                      itemBuilder: (context, index) {
                        return Image.asset(
                          'assets/post_image_$index.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/

import 'package:cloud_firestore/cloud_firestore.dart';

class PerfilOngPage extends StatefulWidget {

  const PerfilOngPage({Key? key}) : super(key: key);

  @override
  State<PerfilOngPage> createState() => _PerfilOngPageState();
}

class _PerfilOngPageState extends State<PerfilOngPage> {

    List<String> fotosURLs = [];

    late String nomeOng = ''; // Valor padrão
    late Perfil perfil = Perfil(idOng: '', descricao: '', endereco: '', contato: '', fotoPerfil: '', fotosURLs: []);


   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User? _user; // Usuário logado

 @override
  void initState() {
    super.initState();
    _user = _auth.currentUser; // Obter usuário logado ao inicializar a página
    if (_user != null) {
      // Se o usuário estiver logado, chame a função para carregar as doações da ONG
      obterNomeOng(_user!.uid);

    }
  }

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (_user != null) {
    obterPerfil(_user!.uid); // Chamar a função para obter o perfil
  }
}

  Future<void> obterNomeOng(String uid) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('ong')
          .doc(uid)
          .get();

      if (snapshot.exists) {
        setState(() {
          nomeOng = snapshot.data()?['nome'];
        });
      }
    } catch (e) {
      print("Erro ao obter o nome da ONG: $e");
    }
  }

  Future<void> obterPerfil(String uid) async {
  try {
    var snapshot = await FirebaseFirestore.instance
        .collection('perfil')
        .doc(uid)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      setState(() {
        perfil = Perfil(
          idOng: data['idOng'] ?? '',
            descricao: data['descricao'] ?? '',
            contato: data['contato'] ?? '',
            endereco: data['endereco'] ?? '',
            fotoPerfil: data['fotoPerfil'] ?? '',
            fotosURLs: List<String>.from(data['fotosURLs'] ?? []),
        );
      });
    }
  } catch (e) {
    print("Erro ao obter o perfil: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leadingWidth: 100.0,
        title: Text("Perfil"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                context: context,
                builder: (context) {
                  return EditarPerfilOng();
                },
              );
               obterPerfil(_user!.uid);
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                context: context,
                builder: (context) {
                  return ConfiguracoesOng();
                },
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: nomeOng != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/profile_image.jpg'),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nomeOng,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            'Descrição: ${perfil.descricao}',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            perfil.contato,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            perfil.endereco,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: 2,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    //--------------------- FOTOS ------------------------------//
                    SizedBox(
                      height: 150,
                      child: fotosURLs.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: fotosURLs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    fotosURLs[index],
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                'Ainda não há nenhuma publicação',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}