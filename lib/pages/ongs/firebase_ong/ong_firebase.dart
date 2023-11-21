import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/ong.dart';
import 'package:intl/intl.dart';

Future<void> salvarDadosNoFirebaseOng(ONG ong, String uid) async {
  try {
    await FirebaseFirestore.instance.collection('ong').doc(uid).set({
      'nome': ong.nome,
      'cpf': ong.cnpj,
      'dataCriacao': DateFormat('yyyy-MM-dd').format(ong.dataCriacao),
     // 'cep':ong.cep,
      'endereco': ong.endereco,
      'numero': ong.numero,
      'complemento': ong.complemento,
      'telefone': ong.telefone,
      'email': ong.email,
      'senha': ong.senha,
      // Adicione outros campos conforme necessário
    });
    print("Dados do usuário armazenados com sucesso.");
  } catch (e) {
    print("Erro ao armazenar dados do usuário: $e");
  }
}


