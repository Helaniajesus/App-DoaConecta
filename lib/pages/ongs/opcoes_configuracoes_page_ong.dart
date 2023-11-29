import 'package:doa_conecta_app/pages/ongs/configuracoes_app_page_ong.dart';
import 'package:doa_conecta_app/pages/ongs/meus_dados_page_ong.dart';
import 'package:flutter/material.dart';

class ConfiguracoesOng extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 12,
      ),

      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          //------------------------ OPÇÃO MEUS DADOS ------------------------//
          buildProfileOption(
            title: 'Meus Dados',
            icon: Icons.person,
            onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MeusDadosPageOng()));
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
                      builder: (context) => const ConfiguracoesAppOngPage()));
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
      ),
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