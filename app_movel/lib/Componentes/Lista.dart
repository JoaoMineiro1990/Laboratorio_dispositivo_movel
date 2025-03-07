import 'package:flutter/material.dart';

class Lista extends StatelessWidget {
  final List<Map<String, dynamic>> itens;
  final IconData iconePadrao;
  final void Function(String titulo, String descricao) onTapItem;

  const Lista({
    super.key,
    required this.itens,
    this.iconePadrao = Icons.list,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itens.length,
      itemBuilder: (context, index) {
        final item = itens[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Icon(
              item['icone'] ?? iconePadrao,
              size: 40,
              color: Colors.brown,
            ),
            title: Text(item['titulo'] ?? 'Sem Título'),
            subtitle: Text(item['descricao'] ?? 'Sem Descrição'),
            onTap: () {
              onTapItem(item['titulo'] ?? 'Sem Título',
                  item['descricao'] ?? 'Sem Descrição');
            },
          ),
        );
      },
    );
  }
}
