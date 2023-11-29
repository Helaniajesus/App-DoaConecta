import 'package:cloud_firestore/cloud_firestore.dart';

// Função para enviar uma mensagem
Future<void> enviarMensagem(String idConversa, String mensagem, String remetente) async {
  try {
    await FirebaseFirestore.instance
        .collection('conversas')
        .doc(idConversa)
        .collection('mensagens')
        .add({
      'mensagem': mensagem,
      'remetente': remetente,
      'timestamp': FieldValue.serverTimestamp(), // Adicione um carimbo de data/hora
    });
    print("Mensagem enviada com sucesso.");
  } catch (e) {
    print("Erro ao enviar mensagem: $e");
  }
}

// Função para recuperar mensagens de uma conversa
Stream<QuerySnapshot> getMensagens(String idConversa) {
  return FirebaseFirestore.instance
      .collection('conversas')
      .doc(idConversa)
      .collection('mensagens')
      .orderBy('timestamp', descending: true) // Ordena as mensagens por data/hora
      .snapshots();
}
