import 'package:doa_conecta_app/doador.dart';
import 'package:doa_conecta_app/pages/doador/configuracoes_page_doador.dart';
import 'package:doa_conecta_app/pages/doador/firebase/doador_firebase.dart';
import 'package:doa_conecta_app/pages/doador/meus_dados_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PerfilDoadorPage extends StatefulWidget {
  const PerfilDoadorPage({Key? key}) : super(key: key);

  @override
  State<PerfilDoadorPage> createState() => _PerfilDoadorPageState();
}

class _PerfilDoadorPageState extends State<PerfilDoadorPage> {

  late User _currentUser;
  Doador? _doador; 

  
@override
void initState() {
  super.initState();
  _getCurrentUser();
}

Future<void> _getCurrentUser() async {
  _currentUser = FirebaseAuth.instance.currentUser!;
  await _getDoador();
}

Future<void> _getDoador() async {
  Doador? doador = await obterDoadorPorId(_currentUser.uid);
  setState(() {
    _doador = doador;
  });
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
      body: _doador != null
          ? buildProfile()
          : const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green),)),
    );
  }

  Widget buildProfile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //----------------- IMAGEM USUARIO ------------------------//
        const CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage('assets/user_profile_image.jpg'),
        ),
        const SizedBox(height: 10),

        //------------------------ NOME USUARIO ------------------------//

        Text(
          _doador?.nome ?? 'Carregando...',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 50),

        //------------------------ OPÇÃO MEUS DADOS ------------------------//
        buildProfileOption(
          title: 'Meus Dados',
          icon: Icons.person,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
        ),
        Divider(),
        const SizedBox(height: 10),

        //------------------------ OPÇÃO CONFIGURAÇÕES DO APP ------------------------//
        buildProfileOption(
          title: 'Configurações do Aplicativo',
          icon: Icons.settings,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ConfiguracoesDoadorPage()));
          },
        ),
        Divider(),
        const SizedBox(height: 10),

        //------------------------ OPÇÃO AJUDA ------------------------//
        buildProfileOption(
          title: 'Ajuda',
          icon: Icons.help,
          onPressed: () {
            // Navegar para a página de Ajuda
          },
        ),
        Divider(),
        const SizedBox(height: 10),

        //------------------------ OPÇÃO SOBRE NOS ------------------------//
        buildProfileOption(
          title: 'Sobre Nós',
          icon: Icons.info,
          onPressed: () {
            // Navegar para a página Sobre Nós
          },
        ),
      ],
    );
  }
}

Widget buildProfileOption({
  required String title,
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 16, 0),
    child: TextButton(
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 24,
            color: Colors.black,
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    ),
  );
}
