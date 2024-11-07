import 'package:flutter/material.dart';

class AdicionarProduto extends StatelessWidget {
  final VoidCallback aoAdicionarProduto; // Callback para adicionar o produto
  final VoidCallback aoCancelar; // Callback para voltar à tela anterior

  const AdicionarProduto({
    super.key,
    required this.aoAdicionarProduto,
    required this.aoCancelar,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem do produto
          const Center(
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_shopping_cart,
                        size: 80, color: Colors.orange), // Ícone do produto
                    SizedBox(height: 10),
                    Text(
                      "NOVO PRODUTO",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Campo de edição - Nome do Produto
          _buildEditableField(
            label: "NOME DO PRODUTO",
            hintText: "Digite o nome do produto",
          ),
          const SizedBox(height: 10),
          // Campo de edição - Data de Validade
          _buildEditableField(
            label: "DATA DE VALIDADE",
            hintText: "Selecione a data de validade",
            trailingIcon: Icons.calendar_today,
          ),
          const SizedBox(height: 10),
          // Campo de edição - Descrição do Produto
          _buildEditableField(
            label: "DESCRIÇÃO",
            hintText: "Descreva o produto",
          ),
          const SizedBox(height: 20),
          // Botões de Adicionar e Voltar
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: aoCancelar, // Callback para voltar
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                  ),
                  child: const Text(
                    'VOLTAR',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: aoAdicionarProduto, // Callback para adicionar
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                  ),
                  child: const Text(
                    'ADICIONAR',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Função auxiliar para construir os campos editáveis
  Widget _buildEditableField({
    required String label,
    required String hintText,
    IconData? trailingIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.orange[100],
            suffixIcon: trailingIcon != null
                ? Icon(trailingIcon, color: Colors.brown)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
