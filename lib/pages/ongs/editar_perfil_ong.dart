import 'package:doa_conecta_app/pages/ongs/firebase_ong/perfil_firebase_ong.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditarPerfilPage(), // Página para editar o perfil
                ),
              );
            },
          ),
          Divider(),
          const SizedBox(height: 10),

          //------------------------ OPÇÃO ADCIONAR FOTO ------------------------//
          buildProfileOption(
            title: 'Adicionar foto',
            icon: Icons.add_a_photo,
            onPressed: () {
              // Lógica para adicionar foto
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

class EditarPerfilPage extends StatefulWidget {
  const EditarPerfilPage({Key? key}) : super(key: key);

  @override
  _EditarPerfilPageState createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _contatoController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();

  String uid = '';

  late FirebaseAuth auth; // Declarar FirebaseAuth

  @override
  void initState() {
    super.initState();
    initializeAuth(); // Chamar método para inicializar auth no initState
  }

  void initializeAuth() {
    auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      uid = user.uid;
      // Faça o que for necessário com o UID
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Editar Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descrição:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descricaoController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Insira a descrição do perfil',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Contato:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contatoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Insira informações de contato',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Endereço:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _enderecoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Insira o endereço',
              ),
            ),
            SizedBox(height: 20),
            /*ElevatedButton(
              onPressed: () async {
                String descricao = _descricaoController.text;
                String contato = _contatoController.text;
                String endereco = _enderecoController.text;
                
             await salvarPerfil(uid, descricao, contato, endereco);
            Navigator.of(context).pop(); // Voltar para a página anterior            
              },
              child: Text('Salvar'),
               style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors
                .green), // Cor alterada para vermelho para melhor identificação
            minimumSize: MaterialStateProperty.all(const Size(200, 50)),
          ),
            ),
          ],
        ),
      ),
    );
  }*/

            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    1, // Define a largura como 70% da largura da tela
                child: ElevatedButton(
                  onPressed: () async {
                    String descricao = _descricaoController.text;
                    String contato = _contatoController.text;
                    String endereco = _enderecoController.text;

                    await salvarPerfil(uid, descricao, contato, endereco);
                    Navigator.of(context)
                        .pop(); // Voltar para a página anterior
                  },
                  child: Text('Salvar'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _contatoController.dispose();
    _enderecoController.dispose();
    super.dispose();
  }
}
