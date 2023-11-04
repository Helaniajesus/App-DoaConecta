import 'package:flutter/material.dart';
import 'senhaEmail_page_ong.dart';
import 'senhaSMS_page_ong.dart';

class EsqueciSenhaPageOng extends StatelessWidget {
  const EsqueciSenhaPageOng({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage logoImage = const AssetImage('assets/images/logo_doa_conecta.png');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Esqueci minha senha"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //--------------------IMAGEM------------------------//
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
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Esqueci a minha senha",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegue para a página de recuperação via e-mail
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SenhaEmailPageOng(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                minimumSize: MaterialStateProperty.all(const Size(200, 50)),
              ),
              child: const Text(
                "Via E-mail",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navegue para a página de recuperação via SMS
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SenhaSMSPageOng(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                minimumSize: MaterialStateProperty.all(const Size(200, 50)),
              ),
              child: const Text(
                "Via SMS",
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
}
