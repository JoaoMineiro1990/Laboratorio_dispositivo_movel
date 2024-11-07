import 'package:flutter/material.dart';

enum TipoNotificacao {
  espacoNaoPreenchido,
  usuarioNaoEncontrado,
  informacaoIncorreta,
  jaExiste,
  ok,
}

class Notificacao {
  static void showNotificacao(BuildContext context, TipoNotificacao tipo) {
    String message;

    switch (tipo) {
      case TipoNotificacao.espacoNaoPreenchido:
        message = "Por favor, preencha todos os campos.";
        break;
      case TipoNotificacao.usuarioNaoEncontrado:
        message = "Usuário não encontrado.";
        break;
      case TipoNotificacao.informacaoIncorreta:
        message = "Informação incorreta.";
        break;
      case TipoNotificacao.jaExiste:
        message = "Usuário ou email já cadastrado.";
        break;
      case TipoNotificacao.ok:
        message = "Ação realizada com sucesso!";
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info, color: Colors.orange[300], size: 40),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center, // Centraliza o botão "OK"
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange[300],
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
