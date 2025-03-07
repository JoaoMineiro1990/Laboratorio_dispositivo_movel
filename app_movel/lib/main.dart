import 'package:app_movel/Telas/Login.dart';
import 'package:app_movel/requisicoes/Conexao.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Conexao.getConnection();

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}
