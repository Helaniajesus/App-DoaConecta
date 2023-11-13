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
        actions: [
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
}
