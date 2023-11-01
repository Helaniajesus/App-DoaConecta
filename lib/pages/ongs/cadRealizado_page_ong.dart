import 'package:flutter/material.dart';
import 'login_page_ong.dart';

class CadRealizadoPageOng extends StatelessWidget {
  const CadRealizadoPageOng({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Carregando a imagem do logo da ONG
    AssetImage logoImage = const AssetImage('assets/images/logo_doa_conecta.png');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Cadastro Realizado"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Layout da imagem
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
          // Mensagem de sucesso
          const Text(
            "Cadastro realizado com sucesso!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          // Botão para entrar
          ElevatedButton(
            onPressed: () {
              // Adicione a ação aqui, por exemplo, para a página inicial.
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPageOng(),
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
              minimumSize: MaterialStateProperty.all(const Size(200, 50)),
            ),
            child: const Text(
              "Entrar",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
