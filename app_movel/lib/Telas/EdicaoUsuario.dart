import 'package:flutter/material.dart';

class EdicaoUsuario extends StatelessWidget {
  final VoidCallback aoCancelar; // Callback para cancelar a edição
  final VoidCallback aoSalvar; // Callback para salvar as alterações

  const EdicaoUsuario({
    super.key,
    required this.aoCancelar,
    required this.aoSalvar,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem de perfil editável
          const Center(
            child: CircleAvatar(
              radius: 50,
              // Você pode colocar uma imagem de rede ou permitir que o usuário selecione uma
            ),
          ),
          const SizedBox(height: 20),
          // Campo editável - Nome
          _buildEditableField(
            label: "NOME",
            hintText: "Digite o nome",
          ),
          const SizedBox(height: 10),
          // Campo editável - Data de Nascimento
          _buildEditableField(
            label: "DATA DE NASCIMENTO",
            hintText: "01/01/2000",
            trailingIcon: Icons.calendar_today,
          ),
          const SizedBox(height: 10),
          // Campo editável - Profissão
          _buildEditableField(
            label: "PROFISSÃO",
            hintText: "Digite a profissão",
          ),
          const SizedBox(height: 10),
          // Campo editável - Email
          _buildEditableField(
            label: "EMAIL",
            hintText: "Digite o email",
          ),
          const SizedBox(height: 20),
          // Botões de Salvar e Cancelar
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: aoCancelar, // Callback para cancelar
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                  ),
                  child: const Text(
                    'CANCELAR',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: aoSalvar, // Callback para salvar
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                  ),
                  child: const Text(
                    'SALVAR',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
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
