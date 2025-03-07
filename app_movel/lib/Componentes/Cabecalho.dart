import 'package:flutter/material.dart';

class Cabecalho extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final IconData icone;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  Cabecalho({
    required this.titulo,
    this.icone = Icons.inventory,
    this.backgroundColor =
        const Color(0xFFFFE0B2),
    this.iconColor = Colors.brown,
    this.textColor = Colors.brown,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(icone, color: iconColor),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                titulo,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Expanded(
            child:
                SizedBox(), // Espaço vazio à direita para centralizar o título
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
