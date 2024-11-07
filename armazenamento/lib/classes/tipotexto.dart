import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TipoTextField {
  apenasLetras,
  letrasNumeros,
  apenasNumeros,
}

class TextFieldCustomizado extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TipoTextField tipo;

  TextFieldCustomizado({
    required this.controller,
    required this.hintText,
    required this.tipo,
  });

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters;

    // Define os filtros de entrada com base no tipo
    switch (tipo) {
      case TipoTextField.apenasLetras:
        inputFormatters = [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
        ];
        break;
      case TipoTextField.letrasNumeros:
        inputFormatters = [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
        ];
        break;
      case TipoTextField.apenasNumeros:
        inputFormatters = [
          FilteringTextInputFormatter.digitsOnly,
        ];
        break;
    }

    return TextField(
      controller: controller,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        border: const OutlineInputBorder(),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
