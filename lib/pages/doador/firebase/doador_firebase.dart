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
    });
    print("Dados do usuário armazenados com sucesso.");
  } catch (e) {
    print("Erro ao armazenar dados do usuário: $e");
  }
}

Future<Doador?> obterDoadorPorId(String idDoador) async {
  try {
    DocumentSnapshot doadorSnapshot = await FirebaseFirestore.instance
        .collection('doador')
        .doc(idDoador)
        .get();

    if (doadorSnapshot.exists) {
      Map<String, dynamic> data = doadorSnapshot.data() as Map<String, dynamic>;

      DateTime? dataNascimento = data['dataNascimento'] != null
          ? DateTime.parse(data['dataNascimento'])
          : null;

      // Verifica se a dataNascimento não é nula antes de criar o objeto Doador
      if (dataNascimento != null) {
        return Doador(
          nome: data['nome'] ?? '',
          cpf: data['cpf'] ?? '',
          dataNascimento: dataNascimento,
          endereco: data['endereco'] ?? '',
          numero: data['numero'] ?? '',
          complemento: data['complemento'] ?? '',
          telefone: data['telefone'] ?? '',
          email: data['email'] ?? '',
          senha: data['senha'] ?? '',
        );
      } else {
        // Caso a data de nascimento seja nula, pode retornar null ou lidar com isso de outra forma
        return null;
      }
    } else {
      return null; // Retorna null se o documento não existir
    }
  } catch (e) {
    print('Erro ao obter dados do doador: $e');
    return null; // Retorna null em caso de erro
  }
}
