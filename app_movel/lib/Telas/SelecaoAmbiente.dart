import 'package:flutter/material.dart';

class SelecaoAmbientes extends StatelessWidget {
  final String tituloEstoque;
  final VoidCallback aoSelecionarProduto; // Callback para acessar próxima tela
  final VoidCallback aoCancelar; // Callback para voltar à tela anterior
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
    final List<String> setores = [
      "Setor de Frios",
      "Setor de Frutas",
      "Setor de Bebidas",
      "Setor de Higiene",
      "Setor de Laticínios",
      "Setor de Carnes",
      "Setor de Verduras",
      "Setor de Limpeza",
      "Setor de Padaria",
    ];

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "SELECIONE O SETOR",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                // Lista de setores
                Column(
                  children: setores.map((setor) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(
                          Icons.inventory,
                          size: 40,
                          color: Colors.brown,
                        ), // Ícone do setor
                        title: Text(
                          setor,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap:
                            aoSelecionarProduto, // Chama o callback ao clicar
                      ),
                    );
                  }).toList(),
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
                onPressed: aoEditarAmbiente, // Callback para editar ambiente
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
                    aoAdicionarAmbiente, // Callback para adicionar ambiente
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
