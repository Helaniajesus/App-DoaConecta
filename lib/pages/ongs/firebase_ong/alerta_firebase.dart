import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doa_conecta_app/pages/ongs/alerta.dart';

Future<void> enviarDadosRecolhimentoParaFirestore(AlertaRecolhimento alerta) async {
  try {
    await FirebaseFirestore.instance.collection('alertas').add({
      'dataRecolhimento': alerta.dataRecolhimento,
      'horarioRecolhimento': alerta.horarioRecolhimento,
      'descricao': alerta.descricao,
      'idDoacao': alerta.idDoacao,
      'idOng': alerta.idOng,
    });
    print('Dados enviados com sucesso para o Firestore!');
  } catch (error) {
    print('Erro ao enviar os dados: $error');
    throw ('Erro ao enviar os dados: $error');
  }
}

Future<void> atualizarDadosRecolhimentoNoFirestore(AlertaRecolhimento alerta) async {
  try {
    // Referência ao documento específico que você quer atualizar
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('alertas').doc(alerta.idDoacao);

    // Atualiza os campos específicos no documento
    await documentReference.update({
      'dataRecolhimento': alerta.dataRecolhimento,
      'horarioRecolhimento': alerta.horarioRecolhimento,
      'descricao': alerta.descricao,
      // Outros campos que você deseja atualizar...
    });

    print('Dados atualizados com sucesso no Firestore!');
  } catch (error) {
    print('Erro ao atualizar os dados: $error');
    throw ('Erro ao atualizar os dados: $error');
  }
}
