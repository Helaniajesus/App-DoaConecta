import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/doacao.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

Future<void> salvarDoacaoNoFirebase(Donation doacao) async {
  try {
    // Salvar os detalhes da doação no Firestore
    await FirebaseFirestore.instance.collection('doacao').add({
      'id': doacao.id,
      'categoria': doacao.categoria,
      'nomeProduto': doacao.nomeProduto,
      'descricao': doacao.descricao,
      'qualidade': doacao.qualidade,
      'tamanho': doacao.tamanho,
      'enderecoRetirada': doacao.enderecoRetirada,
      'fotosURLs': doacao.fotosURLs, // URLs das imagens no Firebase Storage
      'dataPublicacao': Timestamp.fromDate(doacao.dataPublicacao),
      'status': doacao.status,
      'doador': doacao.idDoador, 
      'ong': doacao.idONG
    });

    print("Dados da doação armazenados com sucesso.");
  } catch (e) {
    print("Erro ao armazenar dados da doação: $e");
  }
}

Future<void> apagarDoacaoNoFirebase(id) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('doacao') 
        .where('id', isEqualTo: id ) // Campo onde o valor corresponde ao id da doação a ser apagada
        .get();

    querySnapshot.docs.forEach((doc) async {
      await FirebaseFirestore.instance
          .collection('doacao')
          .doc(doc.id)
          .delete();
    });

    print('Documentos com o valor "123" apagados com sucesso!');
  } catch (e) {
    print('Erro ao apagar documentos: $e');
  }
}

Future<void> adicionarDestinatario(String idDaDoacao, String idOng) async {
  try {
    await FirebaseFirestore.instance
        .collection('doacao')
        .doc(idDaDoacao)
        .update({'ong': idOng});
    print('Status da doação alterado para falso com sucesso!');
  } catch (e) {
    print('Erro ao alterar o status da doação: $e');
  }
}

Future<void> removerDestinatario(String idDaDoacao) async {
  try {
    await FirebaseFirestore.instance
        .collection('doacao')
        .doc(idDaDoacao)
        .update({'ong': ''});
    print('Status da doação alterado para falso com sucesso!');
  } catch (e) {
    print('Erro ao alterar o status da doação: $e');
  }
}

Future<void> marcarDoacaoComoRecolhida(String idDoacao) async {
  try {
    await FirebaseFirestore.instance
        .collection('doacao')
        .doc(idDoacao)
        .update({'status': false}); // Atualize o status da doação para "recolhida"
    
    print('Doação marcada como recolhida com sucesso!');
  } catch (error) {
    print('Erro ao marcar a doação como recolhida: $error');
    // Tratar o erro conforme necessário
  }
}

