import 'package:doa_conecta_app/pages/doador/login_page_doador.dart';
import 'package:doa_conecta_app/pages/ongs/login_page_ong.dart';

import 'package:flutter/material.dart';

class QuemSouEuPage extends StatefulWidget {
  const QuemSouEuPage({Key? key}) : super(key: key);

  @override
  State<QuemSouEuPage> createState() => _QuemSouEuPageState();
}

class _QuemSouEuPageState extends State<QuemSouEuPage> {
  @override
  Widget build(BuildContext context) {
    AssetImage logoImage =
        const AssetImage('assets/images/logo_doa_conecta.png');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                //--------------------IMAGEM------------------------//
                Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      flex: 8,
                      child: Image(
                          image: logoImage,
                          width: 120,
                          height: 200,
                          alignment: Alignment.center),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //-----------------FRASES INICIAIS--------------------//
                const Text(
                  "Bem Vindo ao DoaConecta!",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Eu sou...",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 50,
                ),

                //--------------------- BOTÃO DOADOR---------------------//
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const LoginPageDoador()));
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          //definir tamanho botão
                          minimumSize:
                              MaterialStateProperty.all(const Size(200, 50)),
                        ),
                        child: const Text(
                          "Doador",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                //--------------------- BOTÃO ONG---------------------//
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPageOng()));
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          //definir tamanho botão
                          minimumSize:
                              MaterialStateProperty.all(const Size(200, 50)),
                        ),
                        child: const Text(
                          "ONG",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
