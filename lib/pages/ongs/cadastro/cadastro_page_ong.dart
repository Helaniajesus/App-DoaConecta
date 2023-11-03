import 'package:doa_conecta_app/pages/ongs/cadastro/cadastro2_page_ong.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

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
  DateTime? dataCriacao;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Cadastro ONG"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                //--------------------- Campo Nome ONG --------------------------------//
                TextFormField(
                  controller: nomeOngController,
                  decoration: const InputDecoration(
                    labelText: "Nome da ONG (*)",
                  ),
                  validator: validadorNome,
                ),
                const SizedBox(height: 10),
                //--------------------- Campo CNPJ --------------------------------//

                TextFormField(
                  controller: cnpjController,
                  decoration: const InputDecoration(
                    labelText: "CNPJ (*)",
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter
                        .digitsOnly, // Aceita apenas números
                    CnpjInputFormatter(), // Formata o CNPJ
                  ],
                  keyboardType: TextInputType.number,
                  validator: validadorCnpj,
                ),

                //--------------------- Campo Data Criação --------------------------------//
                TextFormField(
                  controller: dataCriacaoController,
                  decoration: const InputDecoration(
                    labelText: "Data de Criação (*)",
                  ),
                  keyboardType:
                      TextInputType.datetime, // Define o tipo de entrada
                  readOnly: true,
                  onTap: () async {
                    var data = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900, 1, 01),
                        lastDate: DateTime.now());
                    if (data != null) {
                      final formattedDate =
                          DateFormat('dd/MM/yyyy').format(data);
                      setState(() {
                        dataCriacaoController.text = formattedDate;
                        dataCriacao = data;
                      });
                    }
                  },
                  validator: validadorData,
                ),
                const SizedBox(height: 10),
                //--------------------- Campo Endereço ONG --------------------------------//
                TextFormField(
                  controller: enderecoController,
                  decoration: const InputDecoration(
                    labelText: "Endereço (*)",
                  ),
                  validator: validadorEndereco,
                ),
                const SizedBox(height: 10),
                //--------------------- Campo Numero Endereço ONG --------------------------------//
                TextFormField(
                  controller: numeroController,
                  decoration: const InputDecoration(
                    labelText: "Número (*)",
                  ),
                  validator: validadorNumeroEndereco,
                ),
                const SizedBox(height: 10),
                //--------------------- Campo Complemento endereço ONG --------------------------------//
                TextFormField(
                  controller: complementoController,
                  decoration: const InputDecoration(
                    labelText: "Complemento",
                  ),
                ),
                const SizedBox(height: 20),
                //--------------------- Botão proxima página --------------------------------//
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Adicione a ação aqui para navegar para a próxima página (CadastrarOngPage).
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastrarOngPage(),
                        ),
                      );
                    }
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
      ),
    );
  }
}

//------------------Validação Formulario ---------------------------//

//validação Nome
String? validadorNome(String? value) {
  if (value == null || value.isEmpty) {
    return 'Campo obrigatório';
  }
  return null;
}

//validação CNPJ
String? validadorCnpj(String? value) {
  if (value == null || value.isEmpty) {
    return 'Campo obrigatório';
  }

  final cnpjRegex = RegExp(r'^\d{2}(\.\d{3}){2}/\d{4}-\d{2}$');
  if (!cnpjRegex.hasMatch(value)) {
    return 'CNPJ inválido';
  }
  return null;
}

//validação CNPJ
String? validadorData(String? value) {
  if (value == null || value.isEmpty) {
    return 'Campo obrigatório';
  }

  return null;
}

//validação endereco
String? validadorEndereco(String? value) {
  if (value == null || value.isEmpty) {
    return 'Campo obrigatório';
  }
  return null;
}

//validação numero endereco
String? validadorNumeroEndereco(String? value) {
  if (value == null || value.isEmpty) {
    return 'Campo obrigatório';
  }
  return null;
}
