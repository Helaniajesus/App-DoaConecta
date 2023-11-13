import 'package:doa_conecta_app/doador.dart';
import 'package:doa_conecta_app/pages/doador/cadastro/cadastro2_page_doador.dart';
import 'package:doa_conecta_app/pages/doador/firebase/doador_firebase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

class CadastroPageDoador extends StatefulWidget {
  const CadastroPageDoador({Key? key}) : super(key: key);

  @override
  State<CadastroPageDoador> createState() => _CadastroPageDoadorState();
}

class _CadastroPageDoadorState extends State<CadastroPageDoador> {
  TextEditingController nomeOngController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController dataNascimentoController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  DateTime? dataNascimento;

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
                  "Dados Doador",
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
                //--------------------- Campo Nome --------------------------------//
                TextFormField(
                  controller: nomeOngController,
                  decoration: const InputDecoration(
                    labelText: "Nome Completo (*)",
                  ),
                  validator: validadorNome,
                ),
                const SizedBox(height: 10),
                //--------------------- Campo CPF --------------------------------//

                TextFormField(
                  controller: cpfController,
                  decoration: const InputDecoration(
                    labelText: "CPF (*)",
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter
                        .digitsOnly, // Aceita apenas números
                    CpfInputFormatter(), // Formata o CPF
                  ],
                  keyboardType: TextInputType.number,
                  validator: validadorCpf,
                ),

                //--------------------- Campo Data nascimento --------------------------------//
                TextFormField(
                  controller: dataNascimentoController,
                  decoration: const InputDecoration(
                    labelText: "Data de Nascimento (*)",
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
                        dataNascimentoController.text = formattedDate;
                        dataNascimento = data;
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Doador usuario = Doador(
                        nome: nomeOngController.text,
                        cpf: cpfController.text,
                        dataNascimento: dataNascimento ?? DateTime.now(),
                        endereco: enderecoController.text,
                        numero: numeroController.text,
                        complemento: complementoController.text,
                        telefone: "", // Coloque o valor correto se houver
                        email: "", // Coloque o valor correto se houver
                        senha: "", // Coloque o valor correto se houver
                      );

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastrarDoadorPage(doador: usuario),
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
String? validadorCpf(String? value) {
  if (value == null || value.isEmpty) {
    return 'Campo obrigatório';
  }

  final cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$');
  if (!cpfRegex.hasMatch(value)) {
    return 'CPF inválido';
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
