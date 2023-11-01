import 'package:flutter/material.dart';

class ExplorarDoadorPage extends StatefulWidget {
  const ExplorarDoadorPage({Key? key}) : super(key: key);

  @override
  State<ExplorarDoadorPage> createState() => _ExplorarDoadorPageState();
}

class _ExplorarDoadorPageState extends State<ExplorarDoadorPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("DoaConecta"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 100.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),

        //-------------------- BARRA DE PESQUISA -----------------------------------//
        child: SearchAnchor(
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              onTap: () {
                controller.openView();
              },
              onChanged: (_) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
            );
          },
          suggestionsBuilder: (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          },
        ),
      ),
    ); 
  }
}


