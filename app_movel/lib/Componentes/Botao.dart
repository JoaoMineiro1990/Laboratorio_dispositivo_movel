import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final String texto;
  final String tipoNavegacao; 
  final Widget? destino;
  final bool Function()? beforeNavigate; 
  final VoidCallback? onFail; 

  const Botao({
    super.key,
    required this.texto,
    required this.tipoNavegacao,
    this.destino, 
    this.beforeNavigate,
    this.onFail,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (beforeNavigate == null || beforeNavigate!()) {
          switch (tipoNavegacao) {
            case 'push':
              if (destino != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => destino!),
                );
              } else {
                print("Destino é necessário para 'push'");
              }
              break;
            case 'pop':
              Navigator.pop(context);
              break;
            case 'replace':
              if (destino != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => destino!),
                );
              } else {
                print("Destino é necessário para 'replace'");
              }
              break;
            default:
              throw Exception('Tipo de navegação desconhecido: $tipoNavegacao');
          }
        } else {
          if (onFail != null) {
            onFail!();
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), 
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      ),
      child: Text(
        texto,
        style: const TextStyle(
            color: Colors.black, fontSize: 16), 
      ),
    );
  }
}
