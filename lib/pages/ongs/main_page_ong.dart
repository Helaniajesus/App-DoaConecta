import 'package:doa_conecta_app/pages/ongs/doacoes_page_ong.dart';
import 'package:doa_conecta_app/pages/ongs/explorar_page_ong.dart';
import 'package:doa_conecta_app/pages/ongs/contatos_page_ong.dart';
import 'package:doa_conecta_app/pages/ongs/perfil_page_ong.dart';
import 'package:flutter/material.dart';
//import 'package:trilhaapp/pages/pagina1.dart';
//import 'pagina2.dart';
//import 'pagina3.dart';

class MainPageOng extends StatefulWidget {
  const MainPageOng({Key? key}) : super(key: key);

  @override
  State<MainPageOng> createState() => _MainPageOngState();
}

class _MainPageOngState extends State<MainPageOng> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        /*appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("DoaConecta"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 100.0,
        ),*/
        //drawer: CustonDrawer(),
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
                children: const [
                  ExplorarOngPage(),
                  DoacaoOngPage(),
                  ContatoPage(),
                  PerfilOngPage()
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
                    label: "Doação", icon: Icon(Icons.handshake)),
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
