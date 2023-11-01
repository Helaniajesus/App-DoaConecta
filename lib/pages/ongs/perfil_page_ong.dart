import 'package:doa_conecta_app/pages/ongs/configuracoes_page_ong.dart';
import 'package:flutter/material.dart';

class PerfilOngPage extends StatefulWidget {
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
        title: const Text("Perfil"),
        actions: [
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
            icon: const Icon(Icons.add),
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
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
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
                  // ignore: sized_box_for_whitespace
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
