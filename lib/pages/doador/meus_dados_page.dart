import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User? _user;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _userDataStream;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _userDataStream =
        _firestore.collection('doador').doc(_user!.uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Dados'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _userDataStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                    child: Container(
                      width: 50, // Defina a largura desejada
                      height: 50, // Defina a altura desejada
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        strokeWidth: 3,
                      ),
                    ),
                  );
          }

          var userData = snapshot.data!.data();
          if (userData == null) {
            return const Text('Erro ao obter dados do usuário.');
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                ListTile(
                  title: Text('Nome:'),
                  subtitle: Text("${userData['nome']}"),
                ),
                ListTile(
                  title: Text('CPF:'),
                  subtitle: Text('${userData['cpf']}'),
                ),
                ListTile(
                  title: Text('Data de Nascimento:'),
                  subtitle: Text(DateFormat('dd/MM/yyyy').format(
                    (userData['dataNascimento'] is DateTime)
                        ? userData['dataNascimento']
                        : DateTime.parse('${userData['dataNascimento']}'),
                  )),
                ),
                ListTile(
                  title: Text('Endereço:'),
                  subtitle: Text('${userData['endereco']}'),
                ),
                ListTile(
                  title: Text('Número:'),
                  subtitle: Text('${userData['numero']}'),
                ),
                ListTile(
                  title: Text('Complemento:'),
                  subtitle: Text('${userData['complemento']}'),
                ),
                ListTile(
                  title: Text('Telefone:'),
                  subtitle: Text('${userData['telefone']}'),
                ),
                Divider(),
                ListTile(
                  title: Text('E-mail:'),
                  subtitle: Text('${userData['email']}'),
                ),
                ListTile(
                  title: Text('Senha:'),
                  subtitle: Text('${userData['senha']}'),
                ),
                const SizedBox(height: 20),
                //------------------------BOTÃO QUERO DOAR ---------------------------//
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                    
                  ),
                  onPressed: () {
                    // Navegar para a página de edição de perfil
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfilePage(user: _user!)));
                  },
                  child: const Text('Editar Perfil'),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//------------------------ Página editar perfil ------------------------------//
class EditProfilePage extends StatefulWidget {
  final User user;

  const EditProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _complementController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  late FirebaseFirestore _firestore;
  late FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      var snapshot =
          await _firestore.collection('doador').doc(widget.user.uid).get();
      var userData = snapshot.data();

      if (userData != null) {
        _nameController.text = userData['nome'];
        _cpfController.text = userData['cpf'];
        _birthdateController.text = userData['dataNascimento'];
        _addressController.text = userData['endereco'];
        _numberController.text = userData['numero'];
        _complementController.text = userData['complemento'];
        _phoneController.text = userData['telefone'];
        _emailController.text = userData['email'];
        _senhaController.text = userData['senha'];
      }
    } catch (e) {
      print('Erro ao carregar dados do usuário: $e');
    }
  }

Future<void> _reauthenticateUser() async {
  try {
    var userCredential = await _auth.signInWithEmailAndPassword(
      email: widget.user.email!,
      password: _senhaController.text,
    );

    if (userCredential.user != null) {
      // Reautenticação bem-sucedida
      print('Reautenticação bem-sucedida');
    } else {
      // Reautenticação falhou
      print('Falha na reautenticação');
    }
  } catch (e) {
    print('Erro ao reautenticar o usuário: $e');
    // Trate o erro conforme necessário
  }
}

Future<void> _updateUserData() async {
  try {
    await _reauthenticateUser(); // Reautentica o usuário antes de alterar a senha

    // Altera a senha no Firebase Authentication
    await widget.user.updatePassword(_senhaController.text);

    // Atualiza os dados no Firestore
    await _firestore.collection('doador').doc(widget.user.uid).update({
      'nome': _nameController.text,
      'cpf': _cpfController.text,
      'dataNascimento': _birthdateController.text,
      'endereco': _addressController.text,
      'numero': _numberController.text,
      'complemento': _complementController.text,
      'telefone': _phoneController.text,
      'email': _emailController.text,
      'senha': _senhaController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Perfil atualizado com sucesso!'),
    ));
  } catch (e) {
    print('Erro ao atualizar dados do usuário: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _cpfController,
              decoration: const InputDecoration(labelText: 'CPF'),
            ),
            TextField(
              controller: _birthdateController,
              decoration:
                  const InputDecoration(labelText: 'Data de Nascimento'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Endereço'),
            ),
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: 'Número'),
            ),
            TextField(
              controller: _complementController,
              decoration: const InputDecoration(labelText: 'Complemento'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Telefone'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
           
            const SizedBox(height: 20),

            //-------------------- BOTÃO SALVAR ALTERAÇÕES ----------------------------//
            ElevatedButton(
              style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    minimumSize: MaterialStateProperty.all(const Size(600, 50)),
                    
                  ),
              onPressed: () async {
                await _updateUserData(); // Chama a função para atualizar os dados
                Navigator.pop(context); // Volta para a página anterior
              },


              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
