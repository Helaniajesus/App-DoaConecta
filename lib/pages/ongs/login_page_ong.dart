import 'package:doa_conecta_app/pages/ongs/cadastro_page_ong.dart';
import 'package:doa_conecta_app/pages/ongs/main_page_ong.dart';

import 'package:flutter/material.dart';

class LoginPageOng extends StatefulWidget {
  const LoginPageOng({Key? key}) : super(key: key);

  @override
  State<LoginPageOng> createState() => _LoginPageOngState();
}

class _LoginPageOngState extends State<LoginPageOng> {
  var emailController = TextEditingController(text: "email@email.com");
  var senhaController = TextEditingController(text: "123");
  bool isObscureText = true;
  Color deepRed = const Color.fromARGB(255, 128, 0, 0);

  @override
  Widget build(BuildContext context) {
    AssetImage logoImage =
        const AssetImage('assets/images/logo_doa_conecta.png');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("ONG"),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                          height: 170,
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
                  "Ja tem cadastro?",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Faça seu login!",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(
                  height: 40,
                ),
                //-------------------------CAMPO EMAIL------------------------------------//
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: emailController,
                    onChanged: (value) {
                      debugPrint(value);
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 0),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 141, 79, 151))),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.green),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.green,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                //-----------------------COMPO SENHA--------------------------//
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: senhaController,
                    obscureText: isObscureText,
                    onChanged: (value) {
                      debugPrint(value);
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 0),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green)),
                        hintText: "Senha",
                        hintStyle: const TextStyle(color: Colors.black),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.green,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isObscureText = !isObscureText;
                            });
                          },
                          child: Icon(
                            isObscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.green,
                          ),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                //--------------------- BOTÃO ENTRAR---------------------//
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          if (emailController.text.trim() ==
                                  "email@email.com" &&
                              senhaController.text.trim() == "123") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MainPageOng()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Erro ao efetuar o login")));
                          }
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
                          "ENTRAR",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ),
                Expanded(child: Container()),

                //-----------------ESQUECI MINHA SENHA-----------------------------//
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: const Text(
                    "Esqueci minha senha",
                    style: TextStyle(
                        color: Color.fromARGB(255, 151, 21, 21),
                        fontWeight: FontWeight.w400),
                  ),
                ),

                //------------------------CRIAR CONTA---------------------------------//
               Container(
  margin: const EdgeInsets.symmetric(horizontal: 30),
  height: 30,
  alignment: Alignment.center,
  child: TextButton(
    onPressed: () {
      // Adicione aqui a navegação para a página de cadastro
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CadastroPageOng(),
        ),
      );
    },
    child: const Text(
      "Criar conta",
      style: TextStyle(
                        color: Color.fromARGB(255, 151, 21, 21),
                        fontWeight: FontWeight.w400),
                    ),
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





