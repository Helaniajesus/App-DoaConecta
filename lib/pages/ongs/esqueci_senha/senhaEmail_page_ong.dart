import 'package:flutter/material.dart';
import 'novaSenha_page_ong.dart';

class SenhaEmailPageOng extends StatelessWidget {
  const SenhaEmailPageOng({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage logoImage = const AssetImage('assets/images/logo_doa_conecta.png');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Recuperação de Senha via E-mail"),
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
              "Entre com o código",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Um código foi enviado para o seu E-mail",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Inserir 4 quadradinhos onde o usuário digitará a senha de 4 dígitos
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildPinInputField(),
                _buildPinInputField(),
                _buildPinInputField(),
                _buildPinInputField(),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegue para a página de nova senha
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NovaSenhaPageOng(),
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

  // Função para construir os campos de entrada de PIN (senha)
  Widget _buildPinInputField() {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: const TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "0",
          hintStyle: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
