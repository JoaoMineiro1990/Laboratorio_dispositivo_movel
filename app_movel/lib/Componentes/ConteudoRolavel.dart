import 'package:flutter/material.dart';

class ConteudoRolavel extends StatelessWidget {
  final String titulo;
  final List<Map<String, dynamic>> itens;
  final IconData iconePadrao;
  final void Function(String titulo, String descricao) onTapItem;

  const ConteudoRolavel({
    super.key,
    required this.titulo,
    required this.itens,
    required this.onTapItem,
    this.iconePadrao = Icons.list,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: itens.length,
              itemBuilder: (context, index) {
                final item = itens[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: Icon(
                      item['icone'] ?? iconePadrao,
                      size: 40,
                      color: Colors.brown,
                    ),
                    title: Text(
                      item['titulo'] ?? 'Sem Título',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(item['descricao'] ?? 'Sem Descrição'),
                    onTap: () => onTapItem(item['titulo'], item['descricao']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
