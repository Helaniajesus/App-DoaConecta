import 'package:doa_conecta_app/pages/quem_sou_eu_page.dart';
import 'package:flutter/material.dart';
import 'cadRealizado_page_ong.dart'; // Importe a página inicial aqui
import 'package:flutter/services.dart';

class CadastrarOngPage extends StatelessWidget {
  const CadastrarOngPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controladores para os campos de entrada de dados
    TextEditingController telefoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController senhaController = TextEditingController();
    TextEditingController repetirSenhaController = TextEditingController();

    // Expressões regulares para validações
    final telefoneValidator = RegExp(r'^\d{2} \d{5}-\d{4}$');
    final emailValidator = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,3})$');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Login e Contato"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
              // Campo de entrada para o telefone
              TextFormField(
                controller: telefoneController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9 -]')),
                  LengthLimitingTextInputFormatter(13), // Limita a quantidade de caracteres
                ],
                decoration: const InputDecoration(
                  labelText: "Telefone (*) (DD 00000-0000)",
                ),
                validator: (value) {
                  if (!telefoneValidator.hasMatch(value ?? "")) {
                    return "Informe um telefone válido no formato DD 00000-0000";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              // Campo de entrada para o email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email (*)",
                ),
                validator: (value) {
                  if (!emailValidator.hasMatch(value ?? "")) {
                    return "Informe um email válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              // Campo de entrada para a senha
              TextFormField(
                controller: senhaController,
                decoration: const InputDecoration(
                  labelText: "Senha (*)",
                ),
              ),
              const SizedBox(height: 10),
              // Campo de entrada para repetir a senha
              TextFormField(
                controller: repetirSenhaController,
                decoration: const InputDecoration(
                  labelText: "Repetir Senha (*)",
                ),
              ),
              const SizedBox(height: 20),
              // Botão para cadastro
              ElevatedButton(
                onPressed: () {
                  // Navegue para a página inicial, que é a QuemSouEuPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CadRealizadoPageOng(),
                    ),
                  );
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
    );
  }
}
