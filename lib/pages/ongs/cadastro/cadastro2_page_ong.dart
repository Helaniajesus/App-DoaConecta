import 'package:flutter/material.dart';
import 'cadRealizado_page_ong.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:doa_conecta_app/ong.dart';
import 'package:doa_conecta_app/pages/ongs/firebase_ong/ong_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CadastrarOngPage extends StatefulWidget {
  final ONG ong;

  CadastrarOngPage({Key? key, required this.ong}) : super(key: key);

  @override
  _CadastrarOngPageState createState() => _CadastrarOngPageState();
}

class _CadastrarOngPageState extends State<CadastrarOngPage> {
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController repetirSenhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isSenhaVisivel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Login e Contato"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Login e Contato",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Preencha os campos obrigatórios (*)",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: telefoneController,
                  inputFormatters: [maskFormatter],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Celular (*)",
                  ),
                  validator: validadorTelefone,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email (*)",
                  ),
                  validator: validadorEmail,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: senhaController,
                  obscureText: !isSenhaVisivel,
                  decoration: InputDecoration(
                    labelText: "Senha (*)",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _toggleSenhaVisivel();
                      },
                      child: Icon(
                        isSenhaVisivel
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: validadorSenha,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: repetirSenhaController,
                  obscureText: !isSenhaVisivel,
                  decoration: InputDecoration(
                    labelText: "Repetir Senha (*)",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _toggleSenhaVisivel();
                      },
                      child: Icon(
                        isSenhaVisivel
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: validadorConfirmacaoSenha,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      widget.ong.telefone = telefoneController.text;
                      widget.ong.email = emailController.text;
                      widget.ong.senha = senhaController.text;
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: senhaController.text,
                      );
                      String uid = userCredential.user!.uid;
                      await salvarDadosNoFirebaseOng(widget.ong, uid);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CadRealizadoPageOng(),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                  ),
                  child: const Text(
                    "Cadastre-se",
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
        ),
      ),
    );
  }

  String? validadorEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    final emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,3})$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Email inválido';
    }
    return null;
  }

  String? validadorTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    final TelRegExp = RegExp(r'^\(\d{2}\) \d{5}-\d{4}$');
    if (!TelRegExp.hasMatch(value)) {
      return 'Informe um telefone válido';
    }
    return null;
  }

  var maskFormatter = MaskTextInputFormatter(
    mask: "(##) #####-####",
    filter: {"#": RegExp(r'[0-9]')},
  );

  String? validadorSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    } else if (value.length < 6) {
      return 'Senha precisa ter no mínimo 6 caracteres';
    }
    return null;
  }

  String? validadorConfirmacaoSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value != senhaController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  void _toggleSenhaVisivel() {
    setState(() {
      isSenhaVisivel = !isSenhaVisivel;
    });
  }
}
