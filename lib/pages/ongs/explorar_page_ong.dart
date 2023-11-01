import 'package:flutter/material.dart';

class ExplorarOngPage extends StatefulWidget {
  const ExplorarOngPage({Key? key}) : super(key: key);

  @override
  State<ExplorarOngPage> createState() => _ExplorarOngPageState();
}

class _ExplorarOngPageState extends State<ExplorarOngPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leadingWidth: 100.0,
          title: Text("DoaConecta"),
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


