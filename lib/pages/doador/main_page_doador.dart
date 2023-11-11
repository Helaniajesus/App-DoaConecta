import 'package:doa_conecta_app/pages/doador/contatos_page_doador.dart';
import 'package:doa_conecta_app/pages/doador/doar_page_doador.dart';
import 'package:doa_conecta_app/pages/doador/explorar_page_doador.dart';
import 'package:doa_conecta_app/pages/doador/perfil_page_doador.dart';
import 'package:flutter/material.dart';

class MainPageDoador extends StatefulWidget {
  const MainPageDoador({Key? key}) : super(key: key);

  @override
  State<MainPageDoador> createState() => _MainPageDoadorState();
}

class _MainPageDoadorState extends State<MainPageDoador> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    posicaoPagina = value;
                  });
                },
                children: [
                  ExplorarDoadorPage(),
                  DoarDoadorPage(),
                  ContatoPageDoador(),
                  PerfilDoadorPage()
                ],
              ),
            ),
            BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  controller.jumpToPage(value);
                },
                currentIndex: posicaoPagina,
                items: const [
                  BottomNavigationBarItem(
                      label: "Explorar", icon: Icon(Icons.home)),
                  BottomNavigationBarItem(
                      label: "Doar", icon: Icon(Icons.handshake)),
                  BottomNavigationBarItem(
                      label: "Mensagens", icon: Icon(Icons.message)),
                  BottomNavigationBarItem(
                      label: "Perfil", icon: Icon(Icons.person))
                ],
                selectedItemColor: Colors.green,
                )
          ],
        ),
      ),
    );
  }
}