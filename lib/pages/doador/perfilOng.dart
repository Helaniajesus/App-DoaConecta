import 'package:doa_conecta_app/pages/doador/mensagem_page_doador_page.dart';
import 'package:doa_conecta_app/pages/ongs/opcoes_configuracoes_page_ong.dart';
import 'package:doa_conecta_app/pages/ongs/editar_perfil_ong.dart';
import 'package:flutter/material.dart';

class VerPerfilOngPage extends StatefulWidget {
  const VerPerfilOngPage({Key? key}) : super(key: key);

  @override
  State<VerPerfilOngPage> createState() => _VerPerfilOngPage();
}

class _VerPerfilOngPage extends State<VerPerfilOngPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leadingWidth: 100.0,
        title: Text("Perfil"),
        //---------------------- BOTAO MENSAGEM ----------------------------//
        /*actions: [
          IconButton(
            onPressed: () {
               Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MensagemDoadorPage(),
                        ),
                );
            },
            icon: Icon(Icons.message),
          ),
        ],*/
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
                              'Adote um Fucinho',
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
                          'Descrição: Atuamos há mais de 10 anos pela defesa dos animais na cidade de São Paulo.',
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
}

/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/ong.dart'; 
import 'package:flutter/material.dart';

class VerPerfilOngPage extends StatefulWidget {
  final String nome;

  const VerPerfilOngPage({Key? key, required this.nome}) : super(key: key);

  @override
  State<VerPerfilOngPage> createState() => _VerPerfilOngPageState();
}

class _VerPerfilOngPageState extends State<VerPerfilOngPage> {
  late ONG? _ong;

  @override
  void initState() {
    super.initState();
    _getOngDetails();
  }

  Future<void> _getOngDetails() async {
    ONG? ong = await obterOngPorNome(widget.nome);
    setState(() {
      _ong = ong;
    });
  }


Future<ONG?> obterOngPorNome(String nome) async {
  try {
    QuerySnapshot<Map<String, dynamic>> ongsSnapshot = await FirebaseFirestore.instance
        .collection('ong')
        .where('nome', isEqualTo: nome)
        .limit(1)
        .get();

    if (ongsSnapshot.docs.isNotEmpty) {
      Map<String, dynamic> data = ongsSnapshot.docs.first.data();
      DateTime? dataCriacao = data['dataCriacao'] != null
          ? DateTime.parse(data['dataCriacao'])
          : null;

      if (dataCriacao != null) {
        return ONG(
          nome: data['nome'] ?? '',
          cnpj: data['cnpj'] ?? '',
          dataCriacao: dataCriacao,
          endereco: data['endereco'] ?? '',
          numero: data['numero'] ?? '',
          complemento: data['complemento'] ?? '',
          telefone: data['telefone'] ?? '',
          email: data['email'] ?? '',
          senha: data['senha'] ?? '',
        );
      }
    }
    return null; // Retorna null se não encontrar a ONG com o CNPJ fornecido
  } catch (e) {
    print('Erro ao obter dados da ONG por CNPJ: $e');
    return null; // Retorna null em caso de erro
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leadingWidth: 100.0,
        title: const Text("Perfil"),
      ),
      body: _ong != null
          ? SingleChildScrollView(
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
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _ong!.nome,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'CNPJ: ${_ong!.cnpj}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      _ong!., // Adicione aqui a propriedade que representa a descrição da ONG
                      style: const TextStyle(fontSize: 16),
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
}
*/