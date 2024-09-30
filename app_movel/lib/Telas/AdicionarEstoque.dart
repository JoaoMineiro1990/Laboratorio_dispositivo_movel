import 'package:flutter/material.dart';

class Adicionarestoque extends StatelessWidget {
  const Adicionarestoque({super.key});

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
                // Campo de edição - Nome
                _buildEditableField(
                  label: "NOME",
                  hintText: "Digite o nome do estoque",
                ),
                const SizedBox(height: 10),
                // Campo de seleção - Estoque
                _buildEditableField(
                  label: "Descricao do Estoque",
                  hintText: "ESTOQUE1",
                ),
                const SizedBox(height: 10),
                // Campo de seleção - Ambiente
                _buildEditableField(
                  label: "Localizacao do Estoque",
                  hintText: 'rua 10',
                ),
              ],
            ),
          ),
        ),
        // Botões de Salvar e Cancelar fixos na parte inferior
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Função para o botão "SALVAR" (atualmente sem ação)
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                child: const Text(
                  'SALVAR',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Função para o botão "CANCELAR" (atualmente sem ação)
                },
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
