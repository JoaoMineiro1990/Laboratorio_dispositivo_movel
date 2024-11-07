import 'package:armazenamento/telas/homebody.dart';
import 'package:armazenamento/telas/lojabody.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  // Lista de widgets para os diferentes conteúdos do Body
  final List<Widget> _pages = [
    const homebody(),
    const lojabody(),
    const Center(
      child: Text(
        "Se prepare para lutar pelo Imperador",
        style:
            TextStyle(fontSize: 24, fontFamily: 'Oswald', color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
  ];

  // Método para mudar o índice quando um botão for pressionado
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.black, // Fundo da tela principal para combinar com o tema
      appBar: AppBar(
        title: const Text(
          'Warhammer',
          style: TextStyle(
            fontFamily: 'Oswald',
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor:
            const Color(0xFF1C1C1C), // Tom mais escuro para a AppBar
        elevation: 4, // Sombra suave para a AppBar
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        backgroundColor:
            const Color(0xFF1C1C1C), // Cor escura para o fundo da barra
        selectedItemColor:
            Colors.redAccent, // Cor de destaque para o item selecionado
        unselectedItemColor:
            Colors.grey[400], // Cor para os itens não selecionados
        showUnselectedLabels: true, // Para manter todos os labels visíveis
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Personagem',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Loja',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: 'Batalha',
          ),
        ],
      ),
    );
  }
}
