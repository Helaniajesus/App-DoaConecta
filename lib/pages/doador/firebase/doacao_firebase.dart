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