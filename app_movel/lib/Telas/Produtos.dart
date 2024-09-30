import 'package:flutter/material.dart';

class Produtos extends StatelessWidget {
  final VoidCallback
      aoEntrarNoProduto; // Callback para acessar a próxima tela de informações do produto
  final VoidCallback aoCancelar;
  final VoidCallback
      aoAdicionarProduto; // Callback para adicionar um novo produto

  const Produtos({
    super.key,
    required this.aoEntrarNoProduto,
    required this.aoCancelar,
    required this.aoAdicionarProduto,
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
                  "SELECIONE O PRODUTO",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                // Lista de produtos
                Column(
                  children: List.generate(9, (index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.shopping_bag,
                            size: 40, color: Colors.brown), // Ícone do produto
                        title: Text("PRODUTO${index + 1}",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        onTap: aoEntrarNoProduto, // Chama o callback ao clicar
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        // Botões de "Novo" e "Cancelar" fixos
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed:
                    aoAdicionarProduto, // Chama o callback para adicionar
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
                onPressed: aoCancelar, // Chama o callback para cancelar
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
