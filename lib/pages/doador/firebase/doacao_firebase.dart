import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/doacao.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

Future<void> salvarDoacaoNoFirebase(Donation doacao) async {
  try {
    // Salvar os detalhes da doação no Firestore
    await FirebaseFirestore.instance.collection('doacao').add({
      'categoria': doacao.categoria,
      'nomeProduto': doacao.nomeProduto,
      'descricao': doacao.descricao,
      'qualidade': doacao.qualidade,
      'tamanho': doacao.tamanho,
      'enderecoRetirada': doacao.enderecoRetirada,
      'fotosURLs': doacao.fotosURLs, // URLs das imagens no Firebase Storage
      'dataPublicacao': Timestamp.fromDate(doacao.dataPublicacao),
      'status': doacao.status,
      // 'destinatario': doacao.destinatario.toMap(), // ajuste conforme necessário
      // 'doador': doacao.doador.toMap(), // ajuste conforme necessário
    });

    print("Dados da doação armazenados com sucesso.");
  } catch (e) {
    print("Erro ao armazenar dados da doação: $e");
  }
}
