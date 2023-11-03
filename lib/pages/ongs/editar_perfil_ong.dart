import 'package:doa_conecta_app/pages/ongs/configuracoes_app_page_ong.dart';
import 'package:flutter/material.dart';

class EditarPerfilOng extends StatelessWidget {
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
          //------------------------ OPÇÃO EDITAR PERFIL ------------------------//
          buildProfileOption(
            title: 'Editar perfil',
            icon: Icons.edit,
            onPressed: () {
              // Navegar para a página de Meus Dados
            },
          ),
          Divider(),
          const SizedBox(height: 10),

          //------------------------ OPÇÃO ADCIONAR FOTO ------------------------//
          buildProfileOption(
            title: 'Adicionar foto',
            icon: Icons.add_a_photo,
            onPressed: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ));*/
            },
          ),
          Divider(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

//---------------------- configuracoes de estilo opcoes -----------------------//

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