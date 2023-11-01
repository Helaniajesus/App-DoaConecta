import 'package:doa_conecta_app/pages/ongs/cadastrar_page_ong.dart';
import 'package:doa_conecta_app/pages/quem_sou_eu_page.dart';
import 'package:flutter/material.dart';

class CadastroPageOng extends StatefulWidget {
  const CadastroPageOng({Key? key}) : super(key: key);

  @override
  State<CadastroPageOng> createState() => _CadastroPageOngState();
}

class _CadastroPageOngState extends State<CadastroPageOng> {
  TextEditingController nomeOngController = TextEditingController();
  TextEditingController cnpjController = TextEditingController();
  TextEditingController dataCriacaoController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Cadastro ONG"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "Dados ONG",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "(*) Preenchimento obrigatório",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nomeOngController,
                decoration: const InputDecoration(
                  labelText: "Nome da ONG (*)",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: cnpjController,
                decoration: const InputDecoration(
                  labelText: "CNPJ (*)",
                ),
                keyboardType: TextInputType.number, // Aceita apenas números
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: dataCriacaoController,
                decoration: const InputDecoration(
                  labelText: "Data de Criação (*)",
                ),
                keyboardType: TextInputType.datetime, // Define o tipo de entrada
                onTap: () async {
                  // Adicione a seleção da data aqui
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: cepController,
                decoration: const InputDecoration(
                  labelText: "CEP (*)",
                ),
                keyboardType: TextInputType.number, // Aceita apenas números
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: enderecoController,
                decoration: const InputDecoration(
                  labelText: "Endereço (*)",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: numeroController,
                decoration: const InputDecoration(
                  labelText: "Número (*)",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: complementoController,
                decoration: const InputDecoration(
                  labelText: "Complemento (*)",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Adicione a ação aqui para navegar para a próxima página (CadastrarOngPage).
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CadastrarOngPage(),
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
      ),
    );
  }
}
