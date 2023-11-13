import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/doador.dart';
import 'package:intl/intl.dart';

Future<void> salvarDadosNoFirebase(Doador doador, String uid) async {
  try {
    await FirebaseFirestore.instance.collection('doador').doc(uid).set({
      'nome': doador.nome,
      'cpf': doador.cpf,
      'dataNascimento': DateFormat('yyyy-MM-dd').format(doador.dataNascimento),
      'endereco': doador.endereco,
      'numero': doador.numero,
      'complemento': doador.complemento,
      'telefone': doador.telefone,
      'email': doador.email,
      'senha': doador.senha,
      // Adicione outros campos conforme necessário
    });
    print("Dados do usuário armazenados com sucesso.");
  } catch (e) {
    print("Erro ao armazenar dados do usuário: $e");
  }
}


