import 'package:flutter/material.dart';

class SelecaoAmbientes extends StatelessWidget {
  final String tituloEstoque;
  final VoidCallback
      aoSelecionarProduto; // Callback para acessar a próxima tela
  final VoidCallback aoCancelar; // Callback para voltar à tela de EstoqueScreen
  final VoidCallback aoEditarAmbiente; // Callback para editar ambiente
  final VoidCallback
      aoAdicionarAmbiente; // Callback para adicionar novo ambiente

  const SelecaoAmbientes({
    super.key,
    required this.tituloEstoque,
    required this.aoSelecionarProduto,
    required this.aoCancelar,
    required this.aoEditarAmbiente,
    required this.aoAdicionarAmbiente,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "SELECIONE O AMBIENTE",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                // Lista de ambientes como na EstoqueScreen
                Column(
                  children: List.generate(9, (index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.inventory,
                            size: 40, color: Colors.brown), // Ícone do ambiente
                        title: Text("AMBIENTE${index + 1}",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        onTap:
                            aoSelecionarProduto, // Chama o callback ao clicar
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        // Botões fixos (Editar, Novo, Cancelar)
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: aoEditarAmbiente, // Callback para editar o ambiente
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text(
                  'EDITAR',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed:
                    aoAdicionarAmbiente, // Callback para adicionar o ambiente
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text(
                  'NOVO',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: aoCancelar, // Callback para cancelar
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text(
                  'CANCELAR',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
