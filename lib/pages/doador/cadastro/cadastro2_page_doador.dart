import 'package:flutter/material.dart';
import 'cadRealizado_page_doador.dart'; 
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:doa_conecta_app/doador.dart';
import 'package:doa_conecta_app/pages/doador/firebase/doador_firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CadastrarDoadorPage extends StatelessWidget {
  final Doador doador;

  CadastrarDoadorPage({Key? key, required this.doador});

  // Controladores para os campos de entrada de dados
  TextEditingController telefoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController repetirSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
                // Título da página
                const Text(
                  "Login e Contato",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                // Instruções sobre campos obrigatórios
                const Text(
                  "Preencha os campos obrigatórios (*)",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                // ------------ Campo de entrada para telefone --------------------//

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
                // ------------ Campo de entrada para o email--------------------//
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email (*)",
                  ),
                  validator: validadorEmail,
                ),
                const SizedBox(height: 10),
                // ------------ Campo de entrada para o senha --------------------//
                TextFormField(
                  controller: senhaController,
                  decoration: const InputDecoration(
                    labelText: "Senha (*)",
                  ),
                  validator: validadorSenha,
                ),
                const SizedBox(height: 10),
                // ------------ Campo de entrada para repetir senha --------------------//
                TextFormField(
                  controller: repetirSenhaController,
                  decoration: const InputDecoration(
                    labelText: "Repetir Senha (*)",
                  ),
                  validator: validadorConfirmacaoSenha,
                ),
                const SizedBox(height: 20),
                // ------------ Botão para cadastro --------------------//
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      doador.telefone = telefoneController.text;
                      doador.email = emailController.text;
                      doador.senha = senhaController.text;
                      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: senhaController.text,
                      );
                      String uid = userCredential.user!.uid;
                      await salvarDadosNoFirebase(doador, uid);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CadRealizadoPageDoador(),
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
  //------------------Validação Formulario ---------------------------//

//validação email
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

//validação telefone
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

//validação senha
  String? validadorSenha(String? value) {
  if (value == null || value.isEmpty) {
    return 'Campo obrigatório';
  } else if (value.length < 6) {
    return 'Senha precisa ter no mínimo 6 caracteres';
  }
  return null;
}


//validação confirmar senha
  String? validadorConfirmacaoSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    if (value != senhaController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }
}
