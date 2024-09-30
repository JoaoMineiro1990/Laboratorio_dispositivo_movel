import 'package:flutter/material.dart';

class EditarAmbiente extends StatelessWidget {
  final VoidCallback
      aoSalvarAmbiente; 
  const EditarAmbiente({
    super.key,
    required this.aoSalvarAmbiente,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem do ambiente
          const Center(
            child: Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home,
                        size: 80, color: Colors.orange), // Ícone do ambiente
                    SizedBox(height: 10),
                    Text(
                      "AMBIENTE1",
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
          // Campo de edição - Nome
          _buildEditableField(
            label: "NOME",
            hintText: "Digite o nome do ambiente",
          ),
          const SizedBox(height: 10),
          // Campo de edição - Localização
          _buildEditableField(
            label: "LOCALIZAÇÃO",
            hintText: "Digite a localização do ambiente",
          ),
          const SizedBox(height: 10),
          // Campo de edição - Descrição
          _buildEditableField(
            label: "DESCRIÇÃO",
            hintText: "Descreva o ambiente",
          ),
          const SizedBox(height: 20),
          // Botão Salvar
          Center(
            child: ElevatedButton(
              onPressed: aoSalvarAmbiente, // Chama o callback ao pressionar
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
          ),
        ],
      ),
    );
  }

  // Função auxiliar para construir os campos editáveis
  Widget _buildEditableField({
    required String label,
    required String hintText,
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
