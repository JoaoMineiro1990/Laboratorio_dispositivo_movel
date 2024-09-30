import 'package:flutter/material.dart';

class PerfilUsuario extends StatelessWidget {
  final VoidCallback aoEditarPerfil; // Callback para acessar a tela de edição

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
          // Imagem de perfil
          const Center(
            child: CircleAvatar(
              radius: 50, // Tamanho da imagem de perfil
              // backgroundImage: NetworkImage(
              //     'https://i.pinimg.com/originals/7b/7b/7b/'
              // ),
            ),
          ),
          const SizedBox(height: 20),
          // Campo de informação - Nome
          _buildInfoField(
            label: "NOME",
            value: "Harry Styles",
          ),
          const SizedBox(height: 10),
          // Campo de informação - Data de Nascimento
          _buildInfoField(
            label: "DATA DE NASCIMENTO",
            value: "01/02/1994",
          ),
          const SizedBox(height: 10),
          // Campo de informação - Profissão
          _buildInfoField(
            label: "PROFISSÃO",
            value: "Agricultor",
          ),
          const SizedBox(height: 10),
          // Campo de informação - Email
          _buildInfoField(
            label: "EMAIL",
            value: "harrystyles@gmail.com",
          ),
          const SizedBox(height: 20),
          // Botão Editar
          Center(
            child: ElevatedButton(
              onPressed: aoEditarPerfil, // Chama o callback ao clicar
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

  // Função auxiliar para construir os campos de informação
  Widget _buildInfoField({
    required String label,
    required String value,
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
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.orange[100],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            value,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
