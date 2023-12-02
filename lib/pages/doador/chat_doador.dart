import 'package:doa_conecta_app/ong.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/doador.dart';

class DoadorChatPage extends StatefulWidget {
  final ONG? ong;

  const DoadorChatPage({Key? key, this.ong}) : super(key: key);

  @override
  _DoadorChatPageState createState() => _DoadorChatPageState();
}

class _DoadorChatPageState extends State<DoadorChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late User _user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    _user = _auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.green,
        title: Text(widget.ong?.nome ?? 'Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
  stream: _firestore
      .collection('messages')
      .orderBy('timestamp', descending: false) // Altere para descending: false
      .snapshots(),

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        strokeWidth: 3,));
               
                }

                final messages = snapshot.data!.docs;
                List<Widget> messageWidgets = [];

                for (var message in messages) {
                  final data = message.data() as Map<String, dynamic>;

                  if (data.containsKey('text') && data.containsKey('sender')) {
                    final isMe = data['sender'] == _user.email;

                    final messageWidget = buildMessage(
                      text: data['text'],
                      isMe: isMe,
                    );
                    messageWidgets.add(messageWidget);
                  }
                }

                return ListView(
                  reverse: true,
                  children: messageWidgets.reversed.toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Digite sua mensagem...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessage({required String text, required bool isMe}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          if (!isMe)
            CircleAvatar(
              child: Icon(Icons.person),
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (isMe)
            CircleAvatar(
              child: Icon(Icons.person),
            ),
        ],
      ),
    );
  }

 void _sendMessage() {
  String messageText = _messageController.text.trim();
  if (messageText.isNotEmpty) {
    _firestore.collection('messages').add({
      'text': messageText,
      'sender': _user.email,
      'timestamp': DateTime.now(), // Adiciona o campo de timestamp
    });
    _messageController.clear();
  }
}

}
