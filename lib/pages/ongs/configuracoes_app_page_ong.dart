import 'package:doa_conecta_app/pages/quem_sou_eu_page.dart';
import 'package:flutter/material.dart';

class ConfiguracoesAppOngPage extends StatefulWidget {
  const ConfiguracoesAppOngPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracoesAppOngPage> createState() =>
      _ConfiguracoesAppOngPageState();
}

class _ConfiguracoesAppOngPageState extends State<ConfiguracoesAppOngPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("DoaConecta"),
        centerTitle: true,
        leadingWidth: 100.0,
      ),
      body: InkWell(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: double.infinity,
            child: Row(
              children: const [
                Icon(Icons.exit_to_app),
                SizedBox(
                  width: 5,
                ),
                Text("Sair"),
              ],
            )),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  alignment: Alignment.centerLeft,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  title: const Text(
                    "DoaConecta",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Wrap(
                    children: const [
                      Text("Voce sairá do aplicativo!"),
                      Text("Deseja realmente sair do aplicativo?"),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Não")),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const QuemSouEuPage()));
                        },
                        child: const Text("Sim"))
                  ],
                );
              });
        },
      ),
    );
  }
}
