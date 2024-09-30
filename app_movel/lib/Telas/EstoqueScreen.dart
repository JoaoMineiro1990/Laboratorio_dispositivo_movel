import 'package:flutter/material.dart';

class EstoqueScreen extends StatelessWidget {
  final String nomeUsuario; // Recebe o nome do usuário
  final Function(String, String)
      aoSelecionarEstoque; // Callback para selecionar o estoque

  const EstoqueScreen({
    super.key,
    required this.nomeUsuario,
    required this.aoSelecionarEstoque,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> meusEstoques = [
      {
        'titulo': 'Estoque Pessoal 1',
        'descricao': 'Descrição do Estoque Pessoal 1'
      },
      {
        'titulo': 'Estoque Pessoal 2',
        'descricao': 'Descrição do Estoque Pessoal 2'
      },
    ];

    final List<Map<String, String>> estoquesCompartilhados = [
      {
        'titulo': 'Estoque Compartilhado 1',
        'descricao': 'Descrição do Estoque Compartilhado 1'
      },
      {
        'titulo': 'Estoque Compartilhado 2',
        'descricao': 'Descrição do Estoque Compartilhado 2'
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Meus Estoques",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
          ),
          const SizedBox(height: 10),
          // Lista de Meus Estoques
          ...meusEstoques.map((estoque) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading:
                    const Icon(Icons.inventory, size: 40, color: Colors.brown),
                title: Text(estoque['titulo']!),
                subtitle: Text(estoque['descricao']!),
                onTap: () {
                  aoSelecionarEstoque(estoque['titulo']!,
                      estoque['descricao']!); // Chama a função de callback
                },
              ),
            );
          }).toList(),

          const SizedBox(height: 20),
          const Text(
            "Estoques Compartilhados",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown),
          ),
          const SizedBox(height: 10),
          // Lista de Estoques Compartilhados
          ...estoquesCompartilhados.map((estoque) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading:
                    const Icon(Icons.people, size: 40, color: Colors.brown),
                title: Text(estoque['titulo']!),
                subtitle: Text(estoque['descricao']!),
                onTap: () {
                  aoSelecionarEstoque(estoque['titulo']!,
                      estoque['descricao']!); // Chama a função de callback
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
