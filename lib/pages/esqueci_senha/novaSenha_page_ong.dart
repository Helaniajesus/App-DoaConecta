import 'package:doa_conecta_app/pages/esqueci_senha/senhaAlterada_page_ong.dart';
//import 'package:doa_conecta_app/pages/ongs/esqueci_senha/senhaAlterada_page_ong.dart';
import 'package:flutter/material.dart';

class NovaSenhaPageOng extends StatelessWidget {
  const NovaSenhaPageOng({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage logoImage = const AssetImage('assets/images/logo_doa_conecta.png');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Nova Senha"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Adicionar a imagem do logo
            Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 8,
                  child: Image(
                    image: logoImage,
                    width: 120,
                    height: 170,
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Nova senha",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Formulário de senha
            _buildPasswordInput("Senha"),
            _buildPasswordInput("Confirmar Senha"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegue para a página de senha alterada
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SenhaAlteradaPageOng(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                minimumSize: MaterialStateProperty.all(const Size(200, 50)),
              ),
              child: const Text(
                "Continuar",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir campos de entrada de senha
  Widget _buildPasswordInput(String label) {
    return Container(
      width: 250,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
