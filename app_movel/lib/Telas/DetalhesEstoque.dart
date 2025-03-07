import 'package:app_movel/Componentes/Cabecalho.dart';
import 'package:app_movel/Telas/SelecaoAmbiente.dart';
import 'package:flutter/material.dart';
import 'package:app_movel/Componentes/botao.dart';

class DetalheEstoque extends StatelessWidget {
  final String titulo;
  final String descricao;

  const DetalheEstoque({
    super.key,
    required this.titulo,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Cabecalho(
        titulo: 'StockPocket',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.inventory, size: 100, color: Colors.brown),
                    const SizedBox(height: 10),
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    Text(
                      descricao,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Usuários que têm acesso:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                                radius: 24, backgroundColor: Colors.brown),
                            SizedBox(height: 5),
                            Text("Harry Styles"),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                                radius: 24, backgroundColor: Colors.brown),
                            SizedBox(height: 5),
                            Text("Patricia"),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                                radius: 24, backgroundColor: Colors.brown),
                            SizedBox(height: 5),
                            Text("The Flash"),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                                radius: 24, backgroundColor: Colors.brown),
                            SizedBox(height: 5),
                            Text("Stolas"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "INFORMAÇÕES",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "CRIADO EM: 29 de novembro de 2023\n"
              "ÚLTIMA ATUALIZAÇÃO: 24 de agosto de 2024\n"
              "NÚMERO DE AMBIENTES: 10\n"
              "LOCALIZAÇÃO: Rua da minha casa que fica no bairro da minha casa na cidade da minha casa no país onde eu moro.",
              style: TextStyle(fontSize: 14, color: Colors.brown),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Botao(
                    texto: 'ACESSAR',
                    tipoNavegacao: 'push',
                    destino:
                        SelecaoAmbientes(), 
                  ),
                  SizedBox(width: 10),
                  Botao(
                    texto: 'VOLTAR',
                    tipoNavegacao: 'pop',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
