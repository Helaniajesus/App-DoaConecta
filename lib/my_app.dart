import 'package:doa_conecta_app/pages/quem_sou_eu_page.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue),
      home: const QuemSouEuPage(),
    );
  }
}
