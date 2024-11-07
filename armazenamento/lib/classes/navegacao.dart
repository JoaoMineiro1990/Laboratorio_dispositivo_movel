import 'package:flutter/material.dart';

enum TipoNavegacao {
  pop,
  push,
  pushReplacement, // Novo tipo adicionado
}

class Navegacao extends StatelessWidget {
  final BuildContext context;
  final TipoNavegacao tipo;
  final String textoBotao;
  final Widget paginaDestino;

  Navegacao({
    required this.context,
    required this.tipo,
    required this.textoBotao,
    required this.paginaDestino,
  });

  void navegar() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => paginaDestino), // Navegação "pushReplacement"
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: navegar,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8C6E3F),
        shape: const RoundedRectangleBorder(),
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      child: Text(
        textoBotao,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
