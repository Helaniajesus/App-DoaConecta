import 'package:flutter/material.dart';

class MensagemOngPage extends StatefulWidget {
  const MensagemOngPage({Key? key}) : super(key: key);

  @override
  State<MensagemOngPage> createState() => _MensagemOngPageState();
}

class _MensagemOngPageState extends State<MensagemOngPage> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nome Usuario'),
        backgroundColor: Colors.green,
          centerTitle: true,
          leadingWidth: 100.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: 20, // Número de mensagens
              itemBuilder: (context, index) {
                return ChatMessage(
                  text: 'Mensagem de exemplo $index',
                  isMe: index % 2 == 0, // Alterne as mensagens do lado esquerdo e direito
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }
//-------------------- BARRA DE ESCRITA ----------------------------------//
  Widget _buildInputField() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          const Expanded(
            child: TextField(// Atribua o FocusNode ao TextField
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Digite uma mensagem...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Enviar mensagem
            },
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatMessage({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          isMe
              ? Container() // Este espaço é para mensagens do outro usuário
              : const CircleAvatar(
                  // Adicione a imagem do perfil do outro usuário aqui
                ),
          const SizedBox(width: 10),
          Material(
            elevation: 5.0,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: isMe ? const Color.fromARGB(255, 51, 128, 53) : Colors.grey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

