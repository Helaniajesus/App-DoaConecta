import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/ong.dart';
import 'package:intl/intl.dart';

Future<void> salvarDadosPerfilNoFirebaseOng(String uid) async {
  try {
    await FirebaseFirestore.instance
        .collection('perfil')
        .add({
      'idOng': uid,
      'idong': 'idOng',
      'descricao': '',
      'fotoPerfil': '',
      'fotosURLs': '',
    });
    print("Dados do usuário armazenados com sucesso.");
  } catch (e) {
    print("Erro ao armazenar dados do usuário: $e");
  }
}


Future<void> salvarPerfil(String uid, String descricaoController, String contatoController, String enderecoController) async {
    String descricao = descricaoController;
    String contato = contatoController;
    String endereco = enderecoController;

    try {
      await FirebaseFirestore.instance.collection('perfil').doc(uid).set({
        'descricao': descricao,
        'contato': contato,
        'endereco': endereco,
      });

      print("Perfil da ONG atualizado com sucesso.");

    } catch (e) {
      print("Erro ao salvar perfil: $e");
      // Tratar erro, mostrar mensagem de erro, etc.
    }
  }

