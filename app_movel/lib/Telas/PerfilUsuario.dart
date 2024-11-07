import 'package:flutter/material.dart';

class PerfilUsuario extends StatelessWidget {
  final VoidCallback aoEditarPerfil; // Callback para abrir a tela de edição

  const PerfilUsuario({
    super.key,
    required this.aoEditarPerfil,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoField(label: "NOME", value: "Harry Styles"),
          const SizedBox(height: 10),
          _buildInfoField(label: "DATA DE NASCIMENTO", value: "01/02/1994"),
          const SizedBox(height: 10),
          _buildInfoField(label: "PROFISSÃO", value: "Agricultor"),
          const SizedBox(height: 10),
          _buildInfoField(label: "EMAIL", value: "harrystyles@gmail.com"),
          const SizedBox(height: 20),
          // Botão Editar que chama o callback para abrir a tela de edição
          Center(
            child: ElevatedButton(
              onPressed: aoEditarPerfil, // Chama o callback
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
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.orange[100],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(value, style: const TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
