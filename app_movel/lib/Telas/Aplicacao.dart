import 'package:app_movel/Telas/AdicionarAmbiente.dart';
import 'package:app_movel/Telas/PerfilUsuario.dart';
import 'package:app_movel/Telas/SelecaoAmbiente.dart';
import 'package:flutter/material.dart';
import 'package:app_movel/Componentes/cabecalho.dart';

class Aplicacao extends StatefulWidget {
  const Aplicacao({super.key});

  @override
  State<Aplicacao> createState() => _AplicacaoState();
}

class _AplicacaoState extends State<Aplicacao> {
  int indexAtual = 0;

  void _mudarIndex(int novoIndex) {
    setState(() {
      indexAtual = novoIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho(
        titulo: 'StockPocket',
      ),
      body: IndexedStack(
        index: indexAtual,
        children: const [
          SelecaoAmbientes(),
          PerfilUsuario(),
          AdicionarAmbiente(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexAtual,
        backgroundColor: Colors.orange[100],
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: "Perfil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.plus_one, size: 30),
            label: "ADD",
          ),
        ],
        onTap: _mudarIndex,
      ),
    );
  }
}
