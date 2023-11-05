import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'dart:io';

class QueroDoarPage extends StatelessWidget {
  const QueroDoarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leadingWidth: 100.0,
      ),
      body: const DonationForm(),
    );
  }
}

class DonationForm extends StatefulWidget {
  const DonationForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DonationFormState createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  String _selectedCategory = 'Móveis';
  bool _showOtherCategory = false;

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _qualityController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     //controlar a imagem selecionada
    XFile? selectedImage;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: ListView(
        children: <Widget>[
          const Center(
            child: Text(
              "O que você deseja doar?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(
            width: double.infinity,
            child: Text('Categoria:'),
          ),
          SizedBox(
            width: double.infinity,
            child: DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                  _showOtherCategory = newValue == 'Outros';
                });
              },
              items: <String>[
                'Móveis',
                'Comida não perecível',
                'Roupas',
                'Brinquedos',
                'Outros',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          if (_showOtherCategory)
            TextFormField(
              decoration: const InputDecoration(labelText: 'Qual a categoria?'),
            ),
          TextFormField(
            controller: _productNameController,
            decoration: const InputDecoration(labelText: 'Nome do Produto'),
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextFormField(
            controller: _qualityController,
            decoration: const InputDecoration(labelText: 'Estado de Qualidade'),
          ),
          TextFormField(
            controller: _sizeController,
            decoration: const InputDecoration(labelText: 'Tamanho'),
          ),
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(labelText: 'Endereço de Retirada'),
          ),
          //------------------ Botão upload imagem -------------------------//
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
            /*  Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage()));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey),
            ),
            child: const Text(
              "Upload imagem do item",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),*/
          showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: const FaIcon(FontAwesomeIcons.camera),
                          title: const Text("Camera"),
                          onTap: () {
                            openImagePicker(ImageSource.camera);
                           // Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const FaIcon(FontAwesomeIcons.images),
                          title: const Text("Galeria"),
                          onTap: () {
                            openImagePicker(ImageSource.gallery);
                            //Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.upload, // Ícone que você deseja exibir
                    color: Colors.white, // Cor do ícone
                  ),
                  SizedBox(width: 8), // Espaçamento entre o ícone e o texto
                  Text(
                    "Faça o upload de fotos do item", // Texto que você deseja exibir
                    style: TextStyle(
                      color: Colors.white, // Cor do texto
                      fontSize: 16, // Tamanho da fonte
                    ),
                  ),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              )
            ), 
            // Miniatura da imagem selecionada
          if (selectedImage != null)
            Image.file(File(selectedImage!.path), width: 100, height: 100),
          
          //--------------------- Botão concluir -----------------//
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                 Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                minimumSize: MaterialStateProperty.all(const Size(200, 50)),
              ),
              child: const Text(
                "Concluir",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //-------------- abrir galeria e camera --------//
    XFile? photo;

  cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      await GallerySaver.saveImage(croppedFile.path);
      photo = XFile(croppedFile.path);
     // setState(() {});
    }
  }

  void openImagePicker(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    photo = await _picker.pickImage(source: source);
    if (photo != null) {
      String path = (await path_provider.getApplicationDocumentsDirectory()).path;
      String name = basename(photo!.path);
      await photo!.saveTo("$path/$name");

      await GallerySaver.saveImage(photo!.path);

      cropImage(photo!);
    }
  }
}
