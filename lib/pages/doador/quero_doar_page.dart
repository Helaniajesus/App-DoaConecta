import 'package:flutter/material.dart';

class QueroDoarPage extends StatelessWidget {
  const QueroDoarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leadingWidth: 100.0,
      ),
      body: DonationForm(),
    );
  }
}

class DonationForm extends StatefulWidget {
  const DonationForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DonationFormState createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  String _selectedCategory = 'Móveis';
  bool _showOtherCategory = false;

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _qualityController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Center(
            child: Text(
                  "O que você deseja doar?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ),
          
          const SizedBox(height: 20),
          //--------------------- Campo categoria do item ---------------------//
          const SizedBox(
            width: double.infinity, // Ocupa a largura inteira
            child: Text('Categoria:'),
          ),
          SizedBox(
            width: double.infinity, // Ocupa a largura inteira
            child: DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                  _showOtherCategory = newValue == 'Outros';
                });
              },
              items: <String>[
                'Móveis',
                'Comida não perecível',
                'Roupas',
                'Brinquedos',
                'Outros',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          if (_showOtherCategory)
            TextFormField(
              decoration: const InputDecoration(labelText: 'Qual a categoria?'),
            ),
          TextFormField(
            controller: _productNameController,
            decoration: const InputDecoration(labelText: 'Nome do Produto'),
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextFormField(
            controller: _qualityController,
            decoration: const InputDecoration(labelText: 'Estado de Qualidade'),
          ),
          TextFormField(
            controller: _sizeController,
            decoration: const InputDecoration(labelText: 'Tamanho'),
          ),
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(labelText: 'Endereço de Retirada'),
          ),
          //-------------------------- Botão concluir ----------------------//
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
                  onPressed: () {
                   
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                  ),
                  child: const Text(
                    "Concluir",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),),
         
        ],
      ),
    );
  }
}
