/*import 'package:flutter/material.dart';

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
*/

import 'package:doa_conecta_app/pages/ongs/firebase_ong/mensagens_firebase.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*class MensagemOngPage extends StatefulWidget {
  const MensagemOngPage({Key? key}) : super(key: key);

  @override
  State<MensagemOngPage> createState() => _MensagemOngPageState();
}

class _MensagemOngPageState extends State<MensagemOngPage> {
  final TextEditingController _messageController = TextEditingController();
  final CollectionReference _messages =
      FirebaseFirestore.instance.collection('messages');

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _messages.add({
        'text': _messageController.text,
        'timestamp': DateTime.now(),
        // Adicione mais informações do remetente se necessário
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nome Usuário'),
        backgroundColor: Colors.green,
        centerTitle: true,
        leadingWidth: 100.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messages.orderBy('timestamp').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data!.docs.reversed;
                List<ChatMessage> messageWidgets = [];
                for (var message in messages) {
                  final messageText = message['text'];
                  final messageWidget = ChatMessage(
                    text: messageText,
                    isMe: true, // Defina se a mensagem é do usuário atual
                  );
                  messageWidgets.add(messageWidget);
                }

                return ListView(
                  reverse: true,
                  children: messageWidgets,
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _messageController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Digite uma mensagem...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatMessage({Key? key, required this.text, required this.isMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isMe)
            const CircleAvatar(
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
            color: isMe ? Colors.green : Colors.grey,
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
          if (isMe)
            const CircleAvatar(
              // Adicione a imagem do perfil do usuário atual aqui
            ),
        ],
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MensagemDoadorPage extends StatelessWidget {
  final String idConversa; // ID da conversa específica
  MensagemDoadorPage({required this.idConversa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversa'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: getMensagens(idConversa), // Use a função para receber mensagens
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('Sem mensagens.'));
                }
                return ListView(
                  reverse: true, // Exibe as mensagens mais recentes no topo
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['mensagem']),
                      subtitle: Text(data['remetente']),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          // Campo para enviar nova mensagem
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    // Controlador para a nova mensagem
                    // Envie a mensagem quando o botão for pressionado
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Enviar a mensagem utilizando a função enviarMensagem
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

