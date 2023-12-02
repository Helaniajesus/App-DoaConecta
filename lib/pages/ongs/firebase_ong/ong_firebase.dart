import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/ong.dart';
import 'package:intl/intl.dart';

Future<void> salvarDadosNoFirebaseOng(ONG ong, String uid) async {
  try {
    await FirebaseFirestore.instance.collection('ong').doc(uid).set({
      'nome': ong.nome,
      'cnpj': ong.cnpj,
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

Future<ONG?> obterOngPorId(String idOng) async {
  try {
    DocumentSnapshot doadorSnapshot = await FirebaseFirestore.instance
        .collection('ong')
        .doc(idOng)
        .get();

    if (doadorSnapshot.exists) {
      Map<String, dynamic> data = doadorSnapshot.data() as Map<String, dynamic>;

      DateTime? dataCriacao = data['dataCriacao'] != null
          ? DateTime.parse(data['dataCriacao'])
          : null;

      // Verifica se a dataNascimento não é nula antes de criar o objeto Doador
      if (dataCriacao != null) {
        return ONG(
          nome: data['nome'] ?? '',
          cnpj: data['cpf'] ?? '',
          dataCriacao: dataCriacao,
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
    print('Erro ao obter dados da Ong: $e');
    return null; // Retorna null em caso de erro
  }
}
